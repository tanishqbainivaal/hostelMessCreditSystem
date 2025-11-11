from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
import os

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
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    regno = db.Column(db.String(120), unique=True, nullable=False)
    name = db.Column(db.String(200), nullable=False)
    password_hash = db.Column(db.String(200), nullable=False)

    def check_password(self, pw):
        return check_password_hash(self.password_hash, pw)

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
        reg = request.form.get('regno').strip()
        pwd = request.form.get('password')
        if not (name and reg and pwd):
            flash('All fields required', 'error')
            return redirect(url_for('student_signup'))

        # duplicate check
        if User.query.filter_by(regno=reg).first():
            flash('Registration number already exists', 'error')
            return redirect(url_for('student_signup'))

        user = User(name=name, regno=reg, password_hash=generate_password_hash(pwd))
        db.session.add(user)
        db.session.commit()
        flash('Account created. Please log in.', 'success')
        return redirect(url_for('student_login'))

    return render_template('student_signup.html')

@app.route('/student/login', methods=['GET', 'POST'])
def student_login():
    if request.method == 'POST':
        reg = request.form.get('regno').strip()
        pwd = request.form.get('password')
        user = User.query.filter_by(regno=reg).first()
        if not user or not user.check_password(pwd):
            flash('Invalid credentials', 'error')
            return redirect(url_for('student_login'))

        # login
        session.clear()
        session['user_id'] = user.id
        session['user_name'] = user.name
        flash('Logged in', 'success')
        return redirect(url_for('student_dashboard'))

    return render_template('student_login.html')

@app.route('/student/dashboard')
def student_dashboard():
    uid = session.get('user_id')
    if not uid:
        flash('Please login first', 'error')
        return redirect(url_for('student_login'))

    user = User.query.get(uid)
    if not user:
        flash('User not found', 'error')
        return redirect(url_for('student_login'))

    # example data to show on dashboard
    return render_template('student_dashboard.html', user=user)

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
    user = User.query.get(uid)
    return render_template('profile.html', user=user)

if __name__ == '__main__':
    app.run(debug=True, port=5000)
