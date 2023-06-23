using System;
using System.Collections.Generic;

namespace Book_Store.Models.Tables
{
    public partial class Category
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}
