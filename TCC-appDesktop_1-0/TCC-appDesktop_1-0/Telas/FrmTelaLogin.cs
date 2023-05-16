using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace TCC_appDesktop_1_0.Telas
{
    public partial class FrmTelaLogin : Form
    {
        SqlCommand cmd;
        SqlConnection cn;
        SqlDataReader dr;

        public FrmTelaLogin()
        {
            InitializeComponent();
        }

        private void FrmTelaLogin_Load(object sender, EventArgs e)
        {
            cn = new SqlConnection(@"Data Source=.;Initial Catalog=hot_rolls_club;Integrated Security=True");
            cn.Open();
        }

        private void btnEntrar_Click(object sender, EventArgs e)
        {
            cmd = new SqlCommand("select * from Funcionario where email='" + txtUsuario.Text + "' and senha='"+txtSenha.Text+"'", cn);
            //cmd = new SqlCommand("exec usp_login '" + txtUsuario.Text + "', '" + txtSenha.Text + "'", cn);
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                dr.Close();
                this.Hide();
                FrmTelaInicial telaInicial = new FrmTelaInicial();
                telaInicial.ShowDialog();
            }
            else
            {
                dr.Close();
                MessageBox.Show("Usuário ou senha incorretos!", "Erro!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}