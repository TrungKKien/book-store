using System;
using System.Collections.Generic;

namespace Book_Store.Models.Tables
{
    public partial class Comment
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int BookId { get; set; }
        public string Comment1 { get; set; } = null!;

        public virtual Book Book { get; set; } = null!;
        public virtual User User { get; set; } = null!;
    }
}
