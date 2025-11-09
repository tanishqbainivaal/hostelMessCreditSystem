function logout(){
    const confirmLogout = confirm("Do you really want to log out?");
  
  if (confirmLogout) {
    // Redirect to login page
    window.location.href = "index.html";
  } else {
    // User canceled logout
    alert("Logout cancelled.");
  }
}
let but6=document.querySelector("#new_button6");
but6.addEventListener("click",()=>logout());
let arr=document.querySelectorAll(".new_but1");
arr.forEach(but=>{
    but.addEventListener("click",()=>{
        
        let x=document.querySelector("#card");
        if(x==null){
            let y=document.createElement("div");
            document.querySelector("body").appendChild(y);
            y.id="card";
            y.textContent="HOSTEL MESS CREDIT MANAGEMENT SYSTEM";
            return;
        }
        
        if(x.querySelector(".new_button1")!=null){
            let arr=x.querySelectorAll(".new_button1");
            arr.forEach(but=>{
                but.remove();
            });
        }
        
    })
});
let but3=document.querySelector("#new_button3");
but3.addEventListener("click",()=>{
    let x=document.querySelector("#card");
    if(x.querySelector(".new_button1")!=null) return;
    let a=document.createElement("button");
    let b=document.createElement("button");
    let c=document.createElement("button");
    let d=document.createElement("button");
    a.className="new_button1";
    b.className="new_button1";
    c.className="new_button1";
    d.className="new_button1";
    

    a.textContent="BREAKFAST";
    b.textContent="LUNCH";
    c.textContent="SNACKS";
    d.textContent="DINNER";
    document.querySelector("#card").appendChild(a);
    document.querySelector("#card").appendChild(b);
    document.querySelector("#card").appendChild(c);
    document.querySelector("#card").appendChild(d);

});
