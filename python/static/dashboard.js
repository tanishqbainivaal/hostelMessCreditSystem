// small client-side behavior for dashboard (placeholder)
/*function logout(){
    const confirmLogout = confirm("Do you really want to log out?");
  
  if (confirmLogout) {
    // Redirect to login page
    window.location.href = "index.html";
  } else {
    // User canceled logout
    alert("Logout cancelled.");
  }
}*/


let totalCost = 0;
let items = [];
//for fooditems
function fetchMenu() {
  const day = document.getElementById('day').value;
  const meal = document.getElementById('meal').value;
  if (!day || !meal) return;

  fetch('/get_menu_items', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: `day=${day}&meal=${meal}`
  })
  .then(res => res.json())
  .then(data => {
    const container = document.getElementById('menu-items');
    container.innerHTML = "";
    totalCost = 0;
    items = [];

    data.forEach(item => {
      const row = document.createElement('div');
      row.classList.add('menu-row');
      row.innerHTML = `<div>${item.item_name}</div>
    <div>${item.cost}</div>
    <div>
      <input type="number" min="0" value="0"
             data-id="${item.item_id}" data-cost="${item.cost}">
    </div>`;
      container.appendChild(row);
    });

    document.querySelectorAll('#menu-items input').forEach(input => {
      input.addEventListener('input', updateTotal);
    });

    document.getElementById('confirmBtn').disabled = false;
  });
}

document.getElementById('day').addEventListener('change', fetchMenu);
document.getElementById('meal').addEventListener('change', fetchMenu);





function updateTotal() {
  totalCost = 0;
  items = [];
  document.querySelectorAll('#menu-items input').forEach(input => {
    const qty = parseInt(input.value) || 0;
    const cost = parseInt(input.dataset.cost);
    const id = input.dataset.id;
    if (qty > 0) {
      totalCost += qty * cost;
      items.push({ item_id: id, quantity: qty, cost });
    }
  });

  
  const baseBalance = parseInt(document.getElementById('remaining-balance').dataset.balance);
const remaining = baseBalance - totalCost;

  document.getElementById('total-cost').textContent = totalCost;
  document.getElementById('remaining-balance').textContent = remaining >= 0 ? remaining : "Insufficient!";
}

document.getElementById('confirmBtn').addEventListener('click', () => {
  if (!confirm("Are you sure you want to proceed with this purchase?")) return;

  fetch('/purchase', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({ items })
  })
  .then(res => res.json())
  .then(data => {
    alert(data.message);
    document.getElementById('remaining-balance').textContent = data.remaining_balance;
  });
});



