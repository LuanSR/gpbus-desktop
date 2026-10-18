using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace GPbuS
{
    public partial class FormRecSenha : Form
    {
        // E-mail confirmado na etapa de verificação. A troca de senha só vale para ele.
        private string emailVerificado;


        public FormRecSenha()
        {
            InitializeComponent();
        }

        private void btnVerificar_Click(object sender, EventArgs e)
        {
            string cpf = Microsoft.VisualBasic.Interaction.InputBox(
                "Para sua segurança, informe o CPF cadastrado nesta conta:",
                "Confirmação de identidade");
            if (string.IsNullOrWhiteSpace(cpf))
                return;

            bool emailSucesso = DAO_Conexao.verificaEmailECpf(txtEmail.Text, cpf);

            if (emailSucesso)
            {
                lblStatus.Text = "Identidade confirmada!";
                lblStatus.ForeColor = Color.Green;
                emailVerificado = txtEmail.Text;
                txtEmail.Enabled = false;
                // Recupera o nome de usuário e a senha informados nos campos de entrada
                txtSenha.Enabled = true;
                lblsenha.Enabled = true;
                btnConcluir.Enabled = true;

            }
            // Caso contrário, exibe uma mensagem de erro
            else
            {
                lblStatus.Text = DAO_Conexao.UltimoErro != null
                    ? "Erro de conexão com o banco!"
                    : "E-mail ou CPF não conferem!";
                lblStatus.ForeColor= Color.Red;
            }
        }

        private void btnAtualizarSenha_Click(object sender, EventArgs e)
        {
            if (emailVerificado == null)
            {
                MessageBox.Show("Confirme sua identidade antes de definir uma nova senha.");
                return;
            }

            string novoEmail = emailVerificado;
            string novaSenha = txtSenha.Text;
            if (novaSenha.Length < 8)
            {
                MessageBox.Show("A nova senha deve ter pelo menos 8 caracteres.");
                return;
            }

            ADM administrador = new ADM();
            if (administrador.AtualizarSenha(novoEmail, novaSenha))
            {
                MessageBox.Show("Senha atualizada com sucesso");
                FormInicial InicialForm = new FormInicial();
                InicialForm.Show();
                this.Hide();
            }
            else
            {
                MessageBox.Show("Erro na atualização");
            }
        }

        private void gunaGradient2Panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void gunaButton2_Click(object sender, EventArgs e)
        {
            FormInicial InicialForm = new FormInicial();
            InicialForm.Show();
            this.Hide();
        }
    }
    }
