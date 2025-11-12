from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
import os
from datetime import datetime,timedelta
from flask import request, jsonify
from sqlalchemy import text


BASE_DIR = os.path.dirname(os.path.abspath(__file__))



#SQLite via SQLAlchemy; users stored in 'users' table.
# - Passwords hashed with werkzeug.security.
# - Routes: /student/signup, /student/login, /student/dashboard, /student/menu, /student/purchase
app = Flask(__name__)
app.secret_key = os.environ.get('FLASK_SECRET', 'change_this_temp_secret')

# SQLite DB file in backend folder
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(BASE_DIR, 'users.db')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# User model

# ... (Student class definition is fine)

class MenuItem(db.Model):
    __tablename__ = 'MenuItem'
    item_id = db.Column(db.Integer, primary_key=True)
    item_name = db.Column(db.String(100), nullable=False)
    cost = db.Column(db.Integer, nullable=False)

class DailyMenu(db.Model):
    __tablename__ = 'DailyMenu'
    # Assuming this table has a key, perhaps a composite or simple ID
    id = db.Column(db.Integer, primary_key=True)
    day = db.Column(db.String(20), nullable=False)
    meal = db.Column(db.String(20), nullable=False)
    item_id = db.Column(db.Integer, db.ForeignKey('MenuItem.item_id'), nullable=False)

class TransactionLog(db.Model): # ⬅️ CRITICAL FOR THE /purchase ROUTE
    __tablename__ = 'TransactionLog'
    txn_id = db.Column(db.Integer, primary_key=True)
    roll_no = db.Column(db.String(50), db.ForeignKey('Student.roll_no'), nullable=False)
    item_id = db.Column(db.Integer, nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    total_cost = db.Column(db.Integer, nullable=False)
    txn_time = db.Column(db.DateTime, server_default=db.func.now())

# This line now successfully creates all required tables:
with app.app_context():
    db.create_all()

class Student(db.Model):
    __tablename__ = 'Student'  # 🔹 CHANGED: match your actual table name in DB
    roll_no = db.Column(db.String(50), primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    password = db.Column(db.String(255), nullable=False)
    balance = db.Column(db.Integer, default=23000)  # 🔹 CHANGED: default credits
    created_at = db.Column(db.DateTime, server_default=db.func.now())

    def check_password(self, pw):
        return check_password_hash(self.password, pw)

# create DB if missing
with app.app_context():
    db.create_all()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/student/signup', methods=['GET', 'POST'])
def student_signup():
    if request.method == 'POST':
        name = request.form.get('name').strip()
        roll_no = request.form.get('roll_no').strip()
        pwd = request.form.get('password')
        if not (name and roll_no and pwd):
            flash('All fields required', 'error')
            return redirect(url_for('student_signup'))

        # duplicate check
        if Student.query.filter_by(roll_no=roll_no).first():
            flash('Roll number already exists', 'error')
            return redirect(url_for('student_signup'))

        student = Student(
            name=name,
            roll_no=roll_no,
            password=generate_password_hash(pwd)
        )
        db.session.add(student)
        db.session.commit()
        flash('Account created. Please log in.', 'success')
        return redirect(url_for('student_login'))

    return render_template('student_signup.html')

@app.route('/student/login', methods=['GET', 'POST'])
def student_login():
    if request.method == 'POST':
        roll_no = request.form.get('roll_no').strip()
        pwd = request.form.get('password')
        student = Student.query.filter_by(roll_no=roll_no).first()
        if not student or not student.check_password(pwd):
            flash('Invalid credentials', 'error')
            return redirect(url_for('student_login'))

        # login
        session.clear()
        session['user_id'] = student.roll_no
        session['user_name'] = student.name
        flash('Logged in', 'success')
        return redirect(url_for('student_dashboard'))

    return render_template('student_login.html')

@app.route('/student/dashboard')
def student_dashboard():
    uid = session.get('user_id')
    if not uid:
        flash('Please login first', 'error')
        return redirect(url_for('student_login'))

    student = Student.query.get(uid)
    if not student:
        flash('User not found', 'error')
        return redirect(url_for('student_login'))

    # example data to show on dashboard
    return render_template('student_dashboard.html', user=student)

@app.route('/logout')
def logout():
    session.clear()
    flash('Logged out', 'info')
    return redirect(url_for('index'))

@app.route('/admin/login', methods=['GET', 'POST'])
def admin_login():
    if request.method == 'POST':
        flash('Admin login not set up yet', 'info')
    return render_template('admin_login.html')

@app.route('/profile')
def profile():
    uid = session.get('user_id')
    if not uid:
        return redirect(url_for('student_login'))
    student = Student.query.get(uid)
    if student and student.created_at:
        # convert to IST (UTC + 5:30)
        student.created_at = student.created_at + timedelta(hours=5, minutes=30)
    return render_template('profile.html', user=student)

@app.route('/menu')
def menu():
    uid = session.get('user_id')
    if not uid:
        return redirect(url_for('student_login'))
    student = Student.query.get(uid)
    return render_template('menu.html', user=student)

@app.route('/fooditems')
def fooditems():
    uid = session.get('user_id')
    if not uid:
        return redirect(url_for('student_login'))
    student = Student.query.get(uid)
    return render_template('select_fooditems.html', user=student)



@app.route('/feedback')
def feedback():
    uid = session.get('user_id')
    if not uid:
        return redirect(url_for('student_login'))
    student = Student.query.get(uid)
    return render_template('feedback.html', user=student)





@app.route('/get_menu_items', methods=['POST'])
def get_menu_items():
    day = request.form.get('day')
    meal = request.form.get('meal')
    query = text("""
        SELECT MenuItem.item_id, MenuItem.item_name, MenuItem.cost
        FROM DailyMenu
        JOIN MenuItem ON DailyMenu.item_id = MenuItem.item_id
        WHERE DailyMenu.day = :day AND DailyMenu.meal = :meal
    """)
    results = db.session.execute(query, {'day': day, 'meal': meal}).fetchall()

    menu_list = [{'item_id': r[0], 'item_name': r[1], 'cost': r[2]} for r in results]
    return jsonify(menu_list)

@app.route('/purchase', methods=['POST'])
def purchase():
    uid = session.get('user_id')
    if not uid:
        return jsonify({'error': 'Please login first'}), 403

    data = request.json
    items = data.get('items', [])
    total_cost = sum(int(i['cost']) * int(i['quantity']) for i in items)

    student = Student.query.get(uid)

    if student.balance < total_cost:
        return jsonify({'error': 'Insufficient credits!'}), 400

    # Deduct credits
    student.balance -= total_cost
    db.session.commit()

    # Log transactions
    for i in items:
        txn = TransactionLog(
            roll_no=student.roll_no,
            item_id=i['item_id'],
            quantity=i['quantity'],
            total_cost=int(i['cost']) * int(i['quantity'])
        )
        db.session.add(txn)

    db.session.commit()

    return jsonify({
        'message': f'Purchase successful! {total_cost} credits deducted.',
        'remaining_balance': student.balance
    })


@app.route('/history')
def history():
    if 'user_id' not in session:
        flash("Please log in first!", "error")
        return redirect(url_for('student_login'))

    roll_no = session['user_id']
    query=text("""
        SELECT TransactionLog.txn_id, 
               MenuItem.item_name, 
               TransactionLog.quantity,
               TransactionLog.total_cost,
               TransactionLog.txn_time
        FROM TransactionLog
        JOIN MenuItem ON TransactionLog.item_id = MenuItem.item_id
        WHERE TransactionLog.roll_no = :roll_no
        ORDER BY TransactionLog.txn_time DESC
    """)
    transactions = db.session.execute(query, {'roll_no': roll_no}).fetchall()

    txn_list = []
    for txn in transactions:
        utc_time = txn.txn_time

        if utc_time:
            # Convert string → datetime (if needed)
            if isinstance(utc_time, str):
                utc_time = datetime.strptime(utc_time, "%Y-%m-%d %H:%M:%S")

            # Now safely add 5:30 hours for IST
            ist_time = utc_time + timedelta(hours=5, minutes=30)
            formatted_time = ist_time.strftime("%Y-%m-%d %H:%M:%S")
        else:
            formatted_time = "N/A"

        txn_list.append({
            'txn_id': txn.txn_id,
            'item_name': txn.item_name,
            'quantity': txn.quantity,
            'total_cost': txn.total_cost,
            'txn_time': formatted_time
        })

    return render_template('history.html', transactions=txn_list)


if __name__ == '__main__':
    app.run(debug=True, port=5000)