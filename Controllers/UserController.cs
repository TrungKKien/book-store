using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Book_Store.Models;
using Book_Store.Models.Tables;
using Microsoft.AspNetCore.Http;
using System.Web;

namespace Book_Store.Controllers;

public class UserController : Controller
{
    private readonly ILogger<BookstoreController> _logger;

    public UserController(ILogger<BookstoreController> logger)
    {
        _logger = logger;
    }


    public IActionResult Login()
    {
        return View();
    }

    // xử lý đăng nhâp băng c#
    [HttpPost]
    public IActionResult XuLyLogin( user formlogin) 
    {
        if(formlogin.Phone != null || formlogin.Pass != null)
        {
            using (var db = new book_storeContext())
            {
                //kiêmr tra số điên thoại người dùng nhập vào
                // select * form users where c.PhoneNumber == formlogin.Phone 
                var user = db.Users.Where(c => c.PhoneNumber == formlogin.Phone ).FirstOrDefault();  
                
                if(user != null){
                    //kiểm tra pass word và role bằng 0 thì trả về trang home
                    if( user.Password == formlogin.Pass  && user.Role == 0)
                    {
                        return new RedirectResult(url: "/Bookstore/");                    
                    }
                    //kiểm tra password vè role nếu bằng 1 thì trả về trang admin
                    if(user.Password == formlogin.Pass  && user.Role == 1)
                    {
                        return new RedirectResult(url: "/Admin/Categories");
                    }if(user.Password != formlogin.Pass ){
                        return new RedirectResult(url: "/user/login");
                    }
                }else{
                    return new RedirectResult(url: "/user/login");
                }
                    return new RedirectResult(url: "/user/login");
            }
        }else{
            return new RedirectResult(url: "/user/login");
        }
    }
    

    // sử lý ajax js
    [HttpGet]
    public IActionResult XuLyLogin( int Phone ,string Pass ) 
    {
         using (var db = new book_storeContext())
            {
                var user = db.Users.Where(c => c.PhoneNumber == Phone ).FirstOrDefault();  
                if( user.Password == Pass)
                {
                    string[] users = {  user.Id.ToString(), //[0]
                                        user.Name.ToString(),  //[1]
                                        user.Address.ToString(),    //[2]
                                        user.PhoneNumber.ToString(), //[3]
                                        user.Role.ToString()};    //[4]
                    return Ok(users);   
                }
            }
         return new RedirectResult(url: "/user/login");
    }


    public IActionResult Register()
    {
        return View();
    }

    [HttpPost]
    public IActionResult Register(FormSaveNewUser formData)
    {
        // Kiểm tra xác thực người dùng
        if (User.Identity.IsAuthenticated)
        {
            // Người dùng đã đăng nhập, chuyển hướng đến trang chính
            return RedirectToAction("Index", "Home");
        }

        // Kiểm tra tính hợp lệ của các giá trị được nhập vào biểu mẫu
        if (ModelState.IsValid)
        {
            using (var db = new book_storeContext())
            {
                var check = db.Users.FirstOrDefault(c => c.PhoneNumber == formData.PhoneNumber);
                if (check == null)
                {
                    // Thêm người dùng mới vào cơ sở dữ liệu
                    db.Users.Add(new User
                    {
                        Name = formData.Name,
                        PhoneNumber = formData.PhoneNumber,
                        Password = formData.Password,
                        Address = formData.Address,
                        Role = 0
                    });
                    db.SaveChanges();

                    // Chuyển hướng đến trang đăng nhập
                    return RedirectToAction("Login", "User");
                }
                else
                {
                    // Trả về trang đăng ký với thông báo lỗi
                    ViewBag.mess = "Số điện thoại đã được sử dụng. Vui lòng nhập số điện thoại khác.";
                    return View(formData);
                }
            }
        }
        else
        {
            // Trả về trang đăng ký với thông báo lỗi
            ViewBag.mess = "Thông tin đăng ký không hợp lệ";
            return View(formData);
        }
    }
    public IActionResult Edit(int id)
    {
        return View();
    }


    [HttpPost]
    public IActionResult Edit( FormEditUser formData, int id)
    {
        using (var db = new book_storeContext())
        {
            var check = db.Users.FirstOrDefault(c => c.PhoneNumber == formData.phone);
            if(check == null){

                var userUpdate = db.Users.FirstOrDefault(c => c.Id == id);
                if (userUpdate != null)
                {
                    if(formData.name != null || formData.address != null || formData.phone != null){
                        userUpdate.Name = formData.name;
                        userUpdate.PhoneNumber = formData.phone;
                        userUpdate.Address = formData.address;

                        db.Users.Attach(userUpdate);

                        db.SaveChanges();
                        return new RedirectResult(url: "/user/login");
                    }else{
                    }
                    // return new RedirectResult(url: "/user/edit/id=");
                    // return RedirectToAction("edit", "User", new { id = id });
                    return RedirectToAction("edit", "User", new { id = id });   
                }

            }else{
                return RedirectToAction("edit", "User", new { id = id });
            }
            return new RedirectResult(url: "/");
        }
    }



public partial class FormEditUser
    {
        public int phone { get; set; }
        public string name { get; set; }
        public string address { get; set; }
    }  

public partial class user
    {
        public int Phone { get; set; }
        public string Pass { get; set; }
    }
public partial class UserViewModel
        {
        public string Name { get; set; } 
        public int PhoneNumber { get; set; }
        public string Password { get; set; } 
        public string Address { get; set; } 
         public int Role { get; set; }
        
        }
    public partial class FormSaveNewUser
    {
        public int Id { get; set; }
        public string Name { get; set; } 
        public int PhoneNumber { get; set; }
        public string Password { get; set; } 
        public string Address { get; set; } 
        public int Role { get; set; } 
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}