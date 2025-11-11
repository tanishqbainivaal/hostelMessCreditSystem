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
let but=document.querySelector("#new_button_feed");
but.addEventListener("click",()=>{
  document.querySelector("#feed").value="";
});



