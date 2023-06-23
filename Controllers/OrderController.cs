using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Book_Store.Models;
using Book_Store.Models.Tables;
using Microsoft.EntityFrameworkCore;

namespace Book_Store.Controllers;

public class OrderController : Controller
{
    private readonly ILogger<BookstoreController> _logger;

    public OrderController(ILogger<BookstoreController> logger)
    {
        _logger = logger;
    }
    [HttpGet]
    public IActionResult Addcart(int idbook, int iduser, int number )
    {
        using (var db = new book_storeContext())
            {
                // int Number;
                if(number != null){
                    db.Orders.Add(new Order
                    {
                        BookId = idbook,
                        UserId = iduser,
                        Number = number,
                        Status = 0
                    });
                    db.SaveChanges();
                    return new EmptyResult();
                }
                return new EmptyResult();
            }
        return new EmptyResult();
    }
    public RedirectResult Updatecart(int idcart, int status, int number, int idbook)
    {
            using (var db = new book_storeContext())
            {
                if(number == 0){
                    var update = db.Orders.FirstOrDefault(c => c.Id == idcart);
                        update.Status = status;
                        db.Orders.Attach(update);
                        db.SaveChanges();
                    return new RedirectResult(url: "/");


                }else{
                    var update = db.Orders.FirstOrDefault(c => c.Id == idcart);
                        update.Status = status;
                        db.Orders.Attach(update);
                        db.SaveChanges();
                    var updatebook = db.Books.FirstOrDefault(c => c.Id == idbook);
                        updatebook.Number = updatebook.Number - number;

                        db.Books.Attach(updatebook);
                        db.SaveChanges();
                    return new RedirectResult(url: "/admin/orders");

                }
            }
        return new RedirectResult(url: "/admin/orders");
    }

    public IActionResult Index()
    {
        return View();
    }
    [HttpGet]
    public IActionResult Cart(int userId)
    {
            using (var db = new book_storeContext())
            {
                var OrdersList = new OrdersList{
                    Orders = db.Orders.Where(c => c.UserId == userId).ToList(),
                    Books = db.Books.ToList()
                };
            return View(OrdersList);
            }
    }

    public ActionResult Delete(int id, int userId)
    {
        using (var db = new book_storeContext())
        {
            var order = db.Orders.Where(c => c.Id == id).FirstOrDefault();
            if (order != null)
            {
                db.Orders.Remove(order);
                db.SaveChanges();
            }
            return RedirectToAction("Cart", "Order", new { userId = userId });
        }
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
     public partial class OrdersList
    {
        public List<Order> Orders { get; set; }
        public List<Book> Books { get; set; }

    }
}