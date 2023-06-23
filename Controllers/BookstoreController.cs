using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Book_Store.Models;
using Book_Store.Models.Tables;

namespace Book_Store.Controllers;

public class BookstoreController : Controller
{
    private readonly ILogger<BookstoreController> _logger;

    public BookstoreController(ILogger<BookstoreController> logger)
    {
        _logger = logger;
    }
    
   

 
    public IActionResult Index()
    {
        using (var db = new book_storeContext())
        {
            
            var categoriesauthorsViewModel = new CategoriesAuthorsBooksViewModel{
                books = db.Books.ToList(),
                categories = db.Categories.ToList(),
                authors = db.Authors.ToList()
            };
            return View(categoriesauthorsViewModel);
        }
        
        return View();
    }
    [HttpPost]
    public IActionResult Index(int userid){
        using (var db = new book_storeContext())
        {
            if(userid != null){
                var orders = db.Orders.Where(c => c.UserId == userid && c.Status == 0 ).Select(o => o.Id).ToList();
                int number = orders.Count;
                return Ok(number);
            }
            return new EmptyResult();
        }
    }
// 
    public IActionResult Search(string s, int idc , int ida)
    {
        using (var db = new book_storeContext())
        {
            //b1 tao doi tuong
            var books = db.Books.Where(c => c.Name == s || c.CategoryId == idc || c.AuthorId == ida).ToList();
            // var category = db.Books.Where(c => c.CategoryId == id).ToList();

            var categoriesauthorsViewModel = new CategoriesAuthorsBooksViewModel{
                books = books,
                categories = db.Categories.ToList(),
                authors = db.Authors.ToList()
            };
            // categoriesauthorsViewModel.books = books;

            return View(categoriesauthorsViewModel);
        }
        
        return View();
    }
    
    [HttpGet]
    public IActionResult ChiTiet(int id)
    {
        using (var db = new book_storeContext())
        {
            var categoriesauthorsViewModel = new CategoriesAuthorsBooksViewModel{
                book = db.Books.Where(c => c.Id == id).FirstOrDefault(),
                comments = db.Comments.Where(c => c.BookId == id).ToList(),
                categories = db.Categories.ToList(),
                authors = db.Authors.ToList(),
                users = db.Users.ToList()
            };
            return View(categoriesauthorsViewModel);
        }
        return View();
    }

    [HttpGet]
    public IActionResult Addcomment(string comment, int bookid, int userid)
    {
        using (var db = new book_storeContext())
            {
                // push data vào database
                db.Comments.Add(new Comment
                {
                    BookId = bookid,
                    UserId = userid,
                    Comment1 = comment,
                });
                db.SaveChanges();
                // back to categories views
                return new EmptyResult();
            }
        return new EmptyResult();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
    // CategoriesAuthorsBooksViewModel
    public partial class CategoriesAuthorsBooksViewModel
        {
            public List<Category> categories {get; set;} 
            public List<Author> authors {get; set;}
            public List<Book> books { get; set; }
            public List<User> users {get; set;}
            public List<Order> order {get; set;}
            public List<Comment> comments {get; set;}
            public Book book { get; set; }

        }
}