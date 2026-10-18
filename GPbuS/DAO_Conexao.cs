using MySql.Data.MySqlClient;
using System.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace GPbuS
{
    class DAO_Conexao
    {
        public static MySqlConnection con;

        public static string ConnectionString
        {
            get { return ConfigurationManager.ConnectionStrings["GPbuS"].ConnectionString; }
        }

        public static Boolean getConexao()
        {
            Boolean retorno = false;
            try
            {
                con = new MySqlConnection(ConnectionString);
                //con.Open();
                retorno = true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                //con.Close();
            }
            /*finally //não faz diferença nesse caso
            {
                //con.Close();
            }*/
            return retorno;
        }

        /// <summary>Mensagem do último erro de banco, para exibir ao usuário.</summary>
        public static string UltimoErro { get; private set; }

        /// <summary>
        /// Valida o login comparando a senha com o hash salvo.
        /// Contas antigas com senha em texto puro são migradas para hash no primeiro login.
        /// </summary>
        public static bool loginAdministrador(String email, String senha)
        {
            UltimoErro = null;
            string senhaArmazenada = null;
            try
            {
                using (var conexao = new MySqlConnection(ConnectionString))
                {
                    conexao.Open();
                    using (var consulta = new MySqlCommand("SELECT SenhaADM FROM TCC_Administrador WHERE EmailADM = @Email LIMIT 1", conexao))
                    {
                        consulta.Parameters.AddWithValue("@Email", email);
                        object resultado = consulta.ExecuteScalar();
                        senhaArmazenada = resultado == null || resultado == DBNull.Value ? null : resultado.ToString();
                    }

                    if (!Seguranca.VerificarSenha(senha, senhaArmazenada))
                        return false;

                    if (!Seguranca.EstaComHash(senhaArmazenada))
                    {
                        using (var migra = new MySqlCommand("UPDATE TCC_Administrador SET SenhaADM = @Hash WHERE EmailADM = @Email", conexao))
                        {
                            migra.Parameters.AddWithValue("@Hash", Seguranca.GerarHash(senha));
                            migra.Parameters.AddWithValue("@Email", email);
                            migra.ExecuteNonQuery();
                        }
                    }
                    return true;
                }
            }
            catch (Exception ex)
            {
                UltimoErro = ex.Message;
                Console.WriteLine(ex.ToString());
                return false;
            }
        }

        public static bool verificaEmail(String email)
        {
            return verificaEmailECpf(email, null);
        }

        /// <summary>
        /// Confere se existe um administrador com o e-mail e o CPF informados.
        /// Usado na recuperação de senha para impedir que qualquer pessoa troque a senha só sabendo o e-mail.
        /// </summary>
        public static bool verificaEmailECpf(String email, String cpf)
        {
            UltimoErro = null;
            try
            {
                using (var conexao = new MySqlConnection(ConnectionString))
                {
                    conexao.Open();
                    string sql = cpf == null
                        ? "SELECT COUNT(*) FROM TCC_Administrador WHERE EmailADM = @Email"
                        : "SELECT COUNT(*) FROM TCC_Administrador WHERE EmailADM = @Email AND REPLACE(REPLACE(CPFADM, '.', ''), '-', '') = @Cpf";
                    using (var consulta = new MySqlCommand(sql, conexao))
                    {
                        consulta.Parameters.AddWithValue("@Email", email);
                        if (cpf != null)
                            consulta.Parameters.AddWithValue("@Cpf", SomenteDigitos(cpf));
                        return Convert.ToInt32(consulta.ExecuteScalar()) > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                UltimoErro = ex.Message;
                Console.WriteLine(ex.ToString());
                return false;
            }
        }

        private static string SomenteDigitos(string texto)
        {
            var sb = new StringBuilder();
            foreach (char c in texto)
                if (char.IsDigit(c)) sb.Append(c);
            return sb.ToString();
        }
    }
}
    

