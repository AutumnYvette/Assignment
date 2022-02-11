using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;
using System.Net;
using System.Net.Mail;

namespace Assignment
{
    public partial class Registration : System.Web.UI.Page
    {

        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;

        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private int checkPassword(string passwd)
        {
            int score = 0;

            if (passwd.Length < 8)
            {
                return 1;
            }
            else
            {
                score = 1;
            }

            if (Regex.IsMatch(passwd, "[a-z]"))
            {
                score++;
            }

            if ((Regex.IsMatch(passwd, "[0-9]")))
            {
                score++;
            }

            if ((Regex.IsMatch(passwd, "[A-Z]")))
            {
                score++;
            }

            if ((Regex.IsMatch(passwd, "^a-zA-Z0-9")))
            {
                score++;
            }

            return score;
        }
        protected void passwd_Click(object sender, EventArgs e)
        {
            int scores = checkPassword(tb_password.Text);
            string status = "check";
            switch (scores)
            {
                case 1:
                    passwd_status.Text = "Very weak";
                    break;

                case 2:
                    passwd_status.Text = "Weak";
                    break;

                case 3:
                    passwd_status.Text = "Medium";
                    break;

                case 4:
                    passwd_status.Text = "Strong";
                    break;

                case 5:
                    passwd_status.Text = "Very Strong";
                    break;

                default:
                    break;
            }

            passwd_status.Text = status;
            if (scores < 4)
            {
                passwd_status.ForeColor = Color.Red;
                return;
            }
            passwd_status.ForeColor = Color.Green;
        }

        protected void btn_Submit_Click(object sender, EventArgs e)
        {
            if (tb_fname.Text.Length == 0)
            {
                fname_status.Text = "Required field";
                fname_status.ForeColor = Color.Red;
            }

            if (tb_lname.Text.Length == 0)
            {
                lname_status.Text = "Required field";
                lname_status.ForeColor = Color.Red;
            }

            if (tb_password.Text.Length == 0)
            {
                passwordChk.Text = "Required field";
                passwordChk.ForeColor = Color.Red;
            }

            if (tb_credit_no.Text.Length == 0)
            {
                credit_status.Text = "Required field";
                credit_status.ForeColor = Color.Red;
            }

            if (tb_dob.Text.Length == 0)
            {
                dob_status.Text = "Required field";
                dob_status.ForeColor = Color.Red;
            }

            SqlConnection conn = new SqlConnection(MYDBConnectionString);
            string query = "Select * from Register Where Email = '" + tb_email.Text.Trim() + "'";

            SqlDataAdapter sda = new SqlDataAdapter(query, conn);
            DataTable dbt = new DataTable();
            sda.Fill(dbt);

            if (dbt.Rows.Count == 1)
            {
                email_status.Text = "Email has been registered";
                email_status.ForeColor = Color.Red;
            }

            else
            {
                fname_status.Text = " ";
                lname_status.Text = " ";
                credit_status.Text = " ";
                dob_status.Text = " ";
                email_status.Text = " ";
                passwordChk.Text = " ";

                //string pwd = get value from your Textbox
                string passwd = tb_password.Text.ToString().Trim();

                //Generate random "salt"
                RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                byte[] saltByte = new byte[8];

                //Fills array of bytes with a cryptographically strong sequence of random values.
                rng.GetBytes(saltByte);
                salt = Convert.ToBase64String(saltByte);

                SHA512Managed hashing = new SHA512Managed();

                string pwdWithSalt = passwd + salt;
                byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(passwd));
                byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));

                finalHash = Convert.ToBase64String(hashWithSalt);

                RijndaelManaged cipher = new RijndaelManaged();
                cipher.GenerateKey();
                Key = cipher.Key;
                IV = cipher.IV;

                createRegister();

                Response.Redirect("Login.aspx", false);
            }
        }

        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return cipherText;
        }

        protected void createRegister()
        {
            HttpPostedFile userimage = FileUpload1.PostedFile;
            string photo_upload = Path.GetFileName(userimage.FileName);
            FileUpload1.SaveAs(Server.MapPath("photo/" + photo_upload));

            try
            {
                using (SqlConnection con = new SqlConnection(MYDBConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Register VALUES(@fname,@lname, @credit_no, @email, @password, @passwordHash, @passwordSalt, @image, @dob, @IV, @Key, @attempt, @lockoutTime)"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@fname", tb_fname.Text.Trim());
                            cmd.Parameters.AddWithValue("@lname", tb_lname.Text.Trim());
                            cmd.Parameters.AddWithValue("@credit_no", Convert.ToBase64String(encryptData(tb_credit_no.Text.Trim())));
                            cmd.Parameters.AddWithValue("@email", tb_email.Text.Trim());
                            cmd.Parameters.AddWithValue("@password", tb_password.Text.Trim());
                            cmd.Parameters.AddWithValue("@PasswordHash", finalHash);
                            cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                            cmd.Parameters.AddWithValue("@image", photo_upload);
                            cmd.Parameters.AddWithValue("@dob", tb_dob.Text.Trim());
                            cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
                            cmd.Parameters.AddWithValue("@Key", Convert.ToBase64String(Key));
                            cmd.Parameters.AddWithValue("@attempt", 0);
                            cmd.Parameters.AddWithValue("@lockoutTime", DateTime.Now);

                            cmd.Connection = con;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
        }
    }
}