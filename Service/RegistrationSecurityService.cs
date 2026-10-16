using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;


namespace FEHMS_FortEventHireManagementSystem
{
    public static class RegistrationSecurityService
    {
        private const int Iterations = 210000;

        // Convert a password into a salted, secure hash.
        public static string HashPassword(string password)
        {
            byte[] salt = new byte[16];

            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            using (var pbkdf2 = new Rfc2898DeriveBytes(
                password,
                salt,
                Iterations,
                HashAlgorithmName.SHA256))
            {
                byte[] hash = pbkdf2.GetBytes(32);

                return "PBKDF2-SHA256:" +
                    Iterations + ":" +
                    Convert.ToBase64String(salt) + ":" +
                    Convert.ToBase64String(hash);
            }
        }

        // Check a password when the customer signs in.
        public static bool VerifyPassword(
            string password,
            string storedHash)
        {
            try
            {
                string[] parts = storedHash.Split(':');

                if (parts.Length != 4 ||
                    parts[0] != "PBKDF2-SHA256")
                    return false;

                int iterations;

                if (!int.TryParse(parts[1], out iterations) ||
                    iterations < 10000 ||
                    iterations > 2000000)
                    return false;

                byte[] salt = Convert.FromBase64String(parts[2]);
                byte[] expected = Convert.FromBase64String(parts[3]);

                if (salt.Length != 16 || expected.Length != 32)
                    return false;

                using (var pbkdf2 = new Rfc2898DeriveBytes(
                    password,
                    salt,
                    iterations,
                    HashAlgorithmName.SHA256))
                {
                    byte[] actual = pbkdf2.GetBytes(32);

                    int difference = 0;

                    for (int i = 0; i < actual.Length; i++)
                    {
                        difference |= actual[i] ^ expected[i];
                    }

                    return difference == 0;
                }
            }
            catch
            {
                return false;
            }
        }

        // Encrypt the ID number before saving it.
        public static byte[] EncryptIDNumber(string idNumber)
        {
            byte[] idBytes = Encoding.UTF8.GetBytes(idNumber);

            return System.Web.Security.MachineKey.Protect(
                idBytes,
                "FEHMS",
                "CustomerIDNumber");
        }
    }
}
