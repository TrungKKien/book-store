using System;
using System.Collections.Generic;

namespace Book_Store.Models.Tables
{
    public partial class User
    {
        public User()
        {
            Comments = new HashSet<Comment>();
            Orders = new HashSet<Order>();
        }

        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public int PhoneNumber { get; set; }
        public string Password { get; set; } = null!;
        public string Address { get; set; } = null!;
        public int Role { get; set; } 

        public virtual ICollection<Comment> Comments { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
    }
}
