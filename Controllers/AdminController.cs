using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Book_Store.Models;
using Book_Store.Models.Tables;
using Microsoft.EntityFrameworkCore;

namespace Book_Store.Controllers;

public class AdminController : Controller
{
    private readonly ILogger<BookstoreController> _logger;

    public AdminController(ILogger<BookstoreController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index()
    {

  
        return View();
    }



//category

//lấy thông từ database hiển thị thông tin ra bảng category
    public IActionResult Categories()
    {
        //tạo đối tượng db từ lớp book_storeContext
        using (var db = new book_storeContext())
        {
            //b1 tao doi tuong từ lơps CategoriesViewModel
            var categoriesViewModel = new CategoriesViewModel();
            //b2 load du lieu tu db và ganw laij duwx lieeuj vao doi tuong
            categoriesViewModel.categories = db.Categories.ToList();
            //b3  return gửi dữ liệu vừa tạo về view
            return View(categoriesViewModel);
        }
        return View();
    }
    public partial class CategoriesViewModel
    {
        public List<Category> categories { get; set; }
    }

    //gọi view tạo mới category
    public IActionResult CreateCategory()
    {
        return View();
    }

    //lưu thông tin category mới tạo vào data
      [HttpPost]
    public RedirectResult SaveNewCategory(FormSaveNewCategory formData)
    {
        if (formData.name != null)
        {
            if(formData.description != null)
            {
            //tạo đối tượng db từ lớp book_storeContext
                using (var db = new book_storeContext())
                {
                    // push data từ form vào bảng category trong database
                    db.Categories.Add(new Category
                    {
                        Name = formData.name,
                        Description = formData.description
                    });

                    db.SaveChanges(); //lưu
                    //trả về trang category
                    return new RedirectResult(url: "/admin/categories");
                }
            }
            return new RedirectResult(url: "/admin/createCategory");
        }
        return new RedirectResult(url: "/admin/createCategory");
    }

//gọi view update category
    public IActionResult UpdateCategory(int id)
    {
            //tạo đối tượng db từ lớp book_storeContext
        using (var db = new book_storeContext())
        {
            // tìm kiếm đối tượng muốn sửa
            var category = db.Categories.Where(c => c.Id == id).FirstOrDefault();
            if (category != null)
            {
                var viewModel = new UpdateCategoryviewmodel();
                viewModel.category = category;
                // viewModel.Description = Description;
                
                return View(viewModel);
            }
            return new RedirectResult(url: "/Admin/Categories");
        }
    }

    //lưu update vào database
    [HttpPost]
    public RedirectResult SaveUpdateCategory(FormSaveNewCategory formData, int id)
    {
        if (formData.name != null)
        {
            //tạo đối tượng db từ lớp book_storeContext
            using (var db = new book_storeContext())
            {
                // tìm đối tượng muốn sửa bằng id chuyền vào
                var newCategory = db.Categories.FirstOrDefault(c => c.Id == id);
                // gán giá trị mới thay cho data cũ
                    newCategory.Name = formData.name;
                    newCategory.Description = formData.description;

                    //lưu thay đổi
                    db.Categories.Attach(newCategory);                    
                    db.SaveChanges();

                return new RedirectResult(url: "/admin/categories");
            }
        }
        return new RedirectResult(url: "/admin/UpdateCategories");
    }

    //xóa category
    public RedirectResult DeleteCategory(int id)
    {
            //tạo đối tượng db từ lớp book_storeContext
        using (var db = new book_storeContext())
        {
            // tìm kiếm đối tượng muốn xóa bằng id chuyền vào
            var category = db.Categories.Where(c => c.Id == id).FirstOrDefault();
            if (category != null)
            {
                //xóa data
                db.Categories.Remove(category);
                //lưu thay đổi
                db.SaveChanges();
            }
            return new RedirectResult(url: "/Admin/Categories");
        }
    }
    

    

    //author
    // 
    public IActionResult Authors()
    {
        using (var db = new book_storeContext())
        {
            //b1 tao doi tuong
            var authorsViewModel = new AuthorsViewModel();
            //b2 load du lieu tu db
            var Authors = db.Authors.ToList();
            //b3 ganw laij duwx lieeuj vao doi tuong
            authorsViewModel.authors = Authors;
            //b4 return ra view
            return View(authorsViewModel);
        }
        return View();
    }

    //gọi view tạo mới author
    public IActionResult CreateAuthor()
    {
        return View();
    }

    //nhận dữ liệu từ form và lưu vào database
    [HttpPost]
    public RedirectResult SaveNewAuthor(FormSaveNewAuthor formData)
    {
        if (formData.name != null)
        {
            // khởi tạo biến db từ lớp book store
            using (var db = new book_storeContext())
            {
                // push dữ liệu từ form  vào database
                db.Authors.Add(new Author
                {
                    Name = formData.name,
                    Description = formData.description
                });
                
                db.SaveChanges();
                // back to categories views
                return new RedirectResult(url: "/admin/Authors");
            }
        }
        return new RedirectResult(url: "/admin/createAuthor");
    }

    //gọi view update author
    public IActionResult UpdateAuthor(int id)
    {
        using (var db = new book_storeContext())
        {
            // tìm tác giả muốn sửa theo id tấc giả
            var Author = db.Authors.Where(c => c.Id == id).FirstOrDefault();
            if (Author != null)
            {
                var viewModel = new UpdateAuthorviewmodel();
                viewModel.author = Author;
                return View(viewModel);
            }
            return new RedirectResult(url: "/Admin/Authors");
        }

    }

    //lưu update vào data
    public RedirectResult SaveUpdateAuthor(FormSaveNewAuthor formData, int id)
        {
            if (formData.name != null)
            {
                using (var db = new book_storeContext())
                {
                    var newAuthor = db.Authors.FirstOrDefault(c => c.Id == id);
                        newAuthor.Name = formData.name;
                        newAuthor.Description = formData.description;

                        db.Authors.Attach(newAuthor);
                    db.SaveChanges();
                    return new RedirectResult(url: "/admin/authors");
                }
            }
            return new RedirectResult(url: "/admin/updateauthor");
        }
    public RedirectResult DeleteAuthor(int id)
    {
        using (var db = new book_storeContext())
        {
            var author = db.Authors.Where(c => c.Id == id).FirstOrDefault();
            if (author != null)
            {
                db.Authors.Remove(author);
                db.SaveChanges();
            }
            return new RedirectResult(url: "/Admin/Authors");
        }
    }
   






//book
    public IActionResult Books()
        {
            using (var db = new book_storeContext())
            {
                //b1 tao doi tuong
                var booksViewModel = new BooksViewModel();
                //b2 load du lieu tu db
                var books = db.Books.ToList();
                //b3 ganw laij duwx lieeuj vao doi tuong
                booksViewModel.books = books;
                booksViewModel.categories = db.Categories.ToList();
                booksViewModel.authors = db.Authors.ToList();
                //b4 return l
                return View(booksViewModel);
            }
            return View();
        }


        // thêm một quyển sachs mới vào data
      public IActionResult CreateBook()
        {
            using (var db = new book_storeContext())
            {
                var categoriesauthorsViewModel = new CategoriesAuthorsViewModel{
                    categories = db.Categories.ToList(),
                    authors = db.Authors.ToList()
                };
                return View(categoriesauthorsViewModel);
            }
            
            return View();
        }

        // nhận thông tưd form và lưu vào data
       [HttpPost]
    public RedirectResult SaveNewBook(FormSaveNewBook formData)
        {
            if (formData.Name != null)
            {
                
                using (var db = new book_storeContext())
                {
                    // push data vào database
                    db.Books.Add(new Book
                    {
                        Name = formData.Name,
                        CategoryId = formData.CategoryId,
                        AuthorId = formData.AuthorId,
                        Image = formData.Image,
                        Price = formData.Price,
                        Number = formData.Number,
                        Discription = formData.Discription
                    });
                    db.SaveChanges();
                    // back to categories views
                    return new RedirectResult(url: "/admin/Books");
                }
            }
            return new RedirectResult(url: "/admin/createBook");
        }

    public IActionResult UpdateBook(int id)
    {
        using (var db = new book_storeContext())
        {
            var Book = db.Books.Where(c => c.Id == id).FirstOrDefault();
            if (Book != null)
            {
                var viewModel = new UpdateBookviewmodel();
                viewModel.book = Book;
                viewModel.categories = db.Categories.ToList();
                viewModel.authors = db.Authors.ToList();
                return View(viewModel);
            }
            return new RedirectResult(url: "/Admin/Books");
        }

    }
    // lưu thông tin update vào database
    public RedirectResult SaveUpdateBook(FormSaveNewBook formdata, int id)
        {
            if (formdata.Name != null)
            {
                // tạo biến db từ lớp book_store
                using (var db = new book_storeContext())
                {

                    var newBook = db.Books.FirstOrDefault(c => c.Id == id);
                        newBook.Name = formdata.Name;
                        newBook.CategoryId = formdata.CategoryId;
                        newBook.AuthorId = formdata.AuthorId;
                        newBook.Image = formdata.Image;
                        newBook.Price = formdata.Price;
                        newBook.Number = formdata.Number;
                        newBook.Discription = formdata.Discription;

                        db.Books.Attach(newBook);
                    db.SaveChanges();
                    return new RedirectResult(url: "/admin/books");
                }
            }
            return new RedirectResult(url: "/admin/updatebook");
        }

    public RedirectResult DeleteBook(int id)
    {
        using (var db = new book_storeContext())
        {
            var book = db.Books.Where(c => c.Id == id).FirstOrDefault();
            if (book != null)
            {
                db.Books.Remove(book);
                db.SaveChanges();
            }
            return new RedirectResult(url: "/Admin/books");
        }
    }



    public IActionResult orders()
    {
        using (var db = new book_storeContext())
            {
                //b1 tao doi tuong
                var OrdersViewModel = new OrdersViewModel();
                //b2 load du lieu tu db
                var orders = db.Orders.ToList();
                //b3 ganw laij duwx lieeuj vao doi tuong
                OrdersViewModel.orders = orders;
                OrdersViewModel.Books = db.Books.ToList();
                OrdersViewModel.users = db.Users.ToList();
                //b4 return l
                return View(OrdersViewModel);
            }
           
        return View();
        
    }
  

        
    public partial class FormSaveNewAuthor
    {
        public string name { get; set; }
        public string description { get; set; }
    }
    public partial class FormSaveNewBook
    {
        public int AuthorId { get; set; }
        public int CategoryId { get; set; }
        public string Name { get; set; } 
        public string Image { get; set; } 
        public string Discription { get; set; } 
        public int Price { get; set; } 
        public int Number { get; set; }
    }
    
    public partial class FormSaveNewCategory
    {
        public string id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
    }

    public partial class UpdateCategoryviewmodel
    {
        public Category category { get; set; }

    }
      public partial class UpdateAuthorviewmodel
    {
        public Author author { get; set; }

    }
    public partial class UpdateBookviewmodel
    {
        public List<Category> categories {get; set;} 
        public List<Author> authors {get; set;}
        public Book book { get; set; }

    }
    public partial class CategoriesAuthorsViewModel
        {
            public List<Category> categories {get; set;} 
            public List<Author> authors {get; set;}
        }
    
      public partial class OrdersViewModel
    {
        public List<Order> orders { get; set; }
        public List<Book> Books { get; set; }
        public List<User> users { get; set; }
    }

      public partial class AuthorsViewModel
    {
        public List<Author> authors { get; set; }
    }

       public partial class BooksViewModel
    {
        public List<Category> categories {get; set;} 
        public List<Author> authors {get; set;}
        public List<Book> books { get; set; }
    }


    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}
