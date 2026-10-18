using System;
using System.Security.Cryptography;

namespace GPbuS
{
    /// <summary>
    /// Hash de senhas com PBKDF2 (SHA-256 + salt aleatório).
    /// Formato salvo no banco: pbkdf2$iteracoes$saltBase64$hashBase64
    /// </summary>
    public static class Seguranca
    {
        private const int Iteracoes = 100000;
        private const int TamanhoSalt = 16;
        private const int TamanhoHash = 32;
        private const string Prefixo = "pbkdf2";

        public static string GerarHash(string senha)
        {
            byte[] salt = new byte[TamanhoSalt];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            byte[] hash = Derivar(senha, salt, Iteracoes);
            return Prefixo + "$" + Iteracoes + "$" + Convert.ToBase64String(salt) + "$" + Convert.ToBase64String(hash);
        }

        public static bool VerificarSenha(string senha, string armazenado)
        {
            if (string.IsNullOrEmpty(senha) || string.IsNullOrEmpty(armazenado))
                return false;

            // Compatibilidade: contas antigas ainda com senha em texto puro.
            if (!EstaComHash(armazenado))
                return senha == armazenado;

            string[] partes = armazenado.Split('$');
            if (partes.Length != 4)
                return false;

            int iteracoes = int.Parse(partes[1]);
            byte[] salt = Convert.FromBase64String(partes[2]);
            byte[] esperado = Convert.FromBase64String(partes[3]);
            byte[] calculado = Derivar(senha, salt, iteracoes);

            return ComparacaoSegura(esperado, calculado);
        }

        public static bool EstaComHash(string armazenado)
        {
            return armazenado != null && armazenado.StartsWith(Prefixo + "$");
        }

        private static byte[] Derivar(string senha, byte[] salt, int iteracoes)
        {
            using (var pbkdf2 = new Rfc2898DeriveBytes(senha, salt, iteracoes, HashAlgorithmName.SHA256))
            {
                return pbkdf2.GetBytes(TamanhoHash);
            }
        }

        private static bool ComparacaoSegura(byte[] a, byte[] b)
        {
            if (a.Length != b.Length)
                return false;

            int diferenca = 0;
            for (int i = 0; i < a.Length; i++)
                diferenca |= a[i] ^ b[i];

            return diferenca == 0;
        }
    }
}
