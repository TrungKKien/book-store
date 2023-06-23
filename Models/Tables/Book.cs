using System;
using System.Collections.Generic;

namespace Book_Store.Models.Tables
{
    public partial class Book
    {
        public Book()
        {
            Comments = new HashSet<Comment>();
            Orders = new HashSet<Order>();
        }

        public int Id { get; set; }
        public int AuthorId { get; set; }
        public int CategoryId { get; set; }
        public string Name { get; set; } = null!;
        public string Image { get; set; } = null!;
        public string Discription { get; set; } = null!;
        public int Price { get; set; }
        public int Number { get; set; }


    // public string name_category { get; set; }


        public virtual Author Author { get; set; } = null!;
        public virtual ICollection<Comment> Comments { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
    }
}
