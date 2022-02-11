using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;


namespace Assignment
{
    public class Register
    {
        [Required]
 
        public string fname { get; set; }

        [Required]
        public string lname { get; set; }

        [Required, MaxLength(25)]
         public string credit_no { get; set; }
        
        [Required, Key]
        public string email { get; set; }

        [Required, Key, MinLength(12, ErrorMessage = "Enter at least 12 characters"),
        MaxLength(5)]
        public string password { get; set; }

        [Required,DataType(DataType.Date)]
        public DateTime dob { get; set; }
       
        [Required]
        public Byte photo { get; set; }
    }
}