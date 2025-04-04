﻿using kayito_Editor.Forms;
using kayito_Editor.Source;
#if MYSQL
using MySql.Data.MySqlClient;
#else
using System.Data.OleDb;
#endif
using System;
using System.Data;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace kayito_Editor
{
	public partial class Main : Form
	{
		[DllImport("kernel32.dll", SetLastError = true)]
		[return: MarshalAs(UnmanagedType.Bool)]
		static extern bool AllocConsole();

		public Main()
		{
			//AllocConsole();

			//Lectura inicial
			new InitReader();

			InitializeComponent();
		}

		private void Main_Load(object sender, EventArgs e)
		{
			//Conexión a la db
			new MuOnline();

			this.LoadAccounts();

			this.LoadCharacters();

			ItemManager.ReadItemTxt();

			ItemOption.ReadItemOptionTxt();
		}

		private void Main_Close(object sender, FormClosedEventArgs e)
		{
			MuOnline.CloseConnection();
		}

		private void LoadAccounts()
		{
			if (Import.Me_Connection.State != ConnectionState.Open)
			{
				return;
			}

			this.Account_List.Items.Clear();

			string query = null;

			try
			{
				query = $"SELECT memb___id FROM MEMB_INFO";

			#if MYSQL
				MySqlDataReader reader = new MySqlCommand(query, Import.Me_Connection).ExecuteReader();
			#else
				OleDbDataReader reader = new OleDbCommand(query, Import.Me_Connection).ExecuteReader();
			#endif

				object value = null;

				while (reader.Read())
				{
					value = reader.GetValue(0);

					if (this.Account_List.Items.Contains(value))
					{
						continue;
					}

					this.Account_List.Items.Add(value);
				}

				reader.Close();
			}
			catch (Exception exception)
			{
				MessageBox.Show($"[SQL] {query}\n[Error] {exception.Message}\n[Source] {exception.Source}\n[Trace] {exception.StackTrace}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void LoadCharacters()
		{
			if (Import.Mu_Connection.State != ConnectionState.Open)
			{
				return;
			}

			this.Character_List.Items.Clear();

			string query = null;

			try
			{
				query = $"SELECT Name FROM \"Character\"";

			#if MYSQL
				MySqlDataReader reader = new MySqlCommand(query, Import.Mu_Connection).ExecuteReader();
			#else
				OleDbDataReader reader = new OleDbCommand(query, Import.Mu_Connection).ExecuteReader();
			#endif

				object value = null;

				while (reader.Read())
				{
					value = reader.GetValue(0);

					if (this.Character_List.Items.Contains(value))
					{
						continue;
					}

					this.Character_List.Items.Add(value);
				}

				reader.Close();
			}
			catch (Exception exception)
			{
				MessageBox.Show($"[SQL] {query}\n[Error] {exception.Message}\n[Source] {exception.Source}\n[Trace] {exception.StackTrace}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void Btn_Acc_Reload_Click(object sender, EventArgs e)
		{
			this.LoadAccounts();

			MessageBox.Show($"Accounts Reloaded", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
		}

		private void Btn_Char_Reload_Click(object sender, EventArgs e)
		{
			this.LoadCharacters();

			MessageBox.Show($"Characters Reloaded", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
		}

		private void Btn_CreateAccount_Click(object sender, EventArgs e)
		{
			this.Opacity = 0.0d;

			AccountManager accountManager = new AccountManager();

			accountManager.ShowDialog();

			accountManager.Dispose();

			this.LoadAccounts();

			this.Opacity = 1.0d;
		}

		private void Btn_ServerStats_Click(object sender, EventArgs e)
		{
			ServerStats serverStats = new ServerStats();

			serverStats.ShowDialog();

			serverStats.Dispose();
		}

		private void Btn_Exit_Click(object sender, EventArgs e)
		{
			Application.Exit();
		}

		private void Btn_DeleteAllChar_Click(object sender, EventArgs e)
		{
			if (Import.Mu_Connection.State != ConnectionState.Open)
			{
				return;
			}

			MessageBox.Show($"TO USE THIS FUNCTION YOU HAVE TO SHUT DOWN YOUR MU SERVER.", "ATENTION !", MessageBoxButtons.OK, MessageBoxIcon.Information);

			DialogResult result = MessageBox.Show($"Do you want to DELETE ALL CHARACTERS?", "DELETE ALL CHARACTERS", MessageBoxButtons.YesNo);

			if (result == DialogResult.Yes)
			{
				string lastQ = null;

				string executedQ = "{\n";

				bool qResult = true;

				try
				{
					foreach (string query in Import.deleteAllChars)
					{
						lastQ = string.Format(query);

						if (!MuOnline.Mu_ExecuteSQL(lastQ))
						{
							qResult = false;

							break;
						}

						executedQ = executedQ + lastQ + "\n ";
					}

					if (qResult)
					{
						MessageBox.Show($"ALL Characters deleted.", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
					}
					else
					{
						MessageBox.Show($"[Executed] {executedQ}}}\n[Error] {lastQ}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
					}
				}
				catch (Exception exception)
				{
					MessageBox.Show($"[SQL] {lastQ}\n[Error] {exception.Message}\n[Source] {exception.Source}\n[Trace] {exception.StackTrace}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				finally
				{
					this.LoadCharacters();

					this.Character_List.Text = "";

					this.Name_Box.Items.Clear();

					this.Name_Box.Text = "";
				}
			}
		}

		private void Btn_DeleteAllDB_Click(object sender, EventArgs e)
		{
			if (Import.Mu_Connection.State != ConnectionState.Open || Import.Me_Connection.State != ConnectionState.Open)
			{
				return;
			}

			MessageBox.Show($"TO USE THIS FUNCTION YOU HAVE TO SHUT DOWN YOUR MU SERVER.", "ATENTION !", MessageBoxButtons.OK, MessageBoxIcon.Information);

			DialogResult result = MessageBox.Show($"Do you want to DELETE ALL THE DATABASE?", "DELETE ALL DATABASE", MessageBoxButtons.YesNo);

			if (result == DialogResult.Yes)
			{
				string lastQ = null;

				string executedQ = "{\n";

				bool qResult = true;

				try
				{
					foreach (string query in Import.deleteAllDB)
					{
						lastQ = string.Format(query);

						if (lastQ.Contains("MEMB_INFO") || lastQ.Contains("MEMB_STAT"))
						{
							if (!MuOnline.Me_ExecuteSQL(lastQ))
							{
								qResult = false;

								break;
							}
						}
						else
						{
							if (!MuOnline.Mu_ExecuteSQL(lastQ))
							{
								qResult = false;

								break;
							}
						}

						executedQ = executedQ + lastQ + "\n ";
					}

					if (qResult)
					{
						MessageBox.Show($"ALL DATABASE deleted.", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
					}
					else
					{
						MessageBox.Show($"[Executed] {executedQ}}}\n[Error] {lastQ}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
					}
				}
				catch (Exception exception)
				{
					MessageBox.Show($"[SQL] {lastQ}\n[Error] {exception.Message}\n[Source] {exception.Source}\n[Trace] {exception.StackTrace}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				finally
				{
					this.LoadAccounts();

					this.Account_List.Text = "";

					this.LoadCharacters();

					this.Character_List.Text = "";

					this.Name_Box.Items.Clear();

					this.Name_Box.Text = "";
				}
			}
		}

		private void Btn_About_Click(object sender, EventArgs e)
		{
			About about = new About();

			about.ShowDialog();

			about.Dispose();
		}

		private void Account_List_TextChanged(object sender, EventArgs e)
		{
			this.Character_Info_Box.Enabled = false;

			this.Btn_CreateCharacter.Enabled = false;

			this.Account_Info_Box.Enabled = false;
		}

		private void Account_List_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (Import.Me_Connection.State != ConnectionState.Open)
			{
				return;
			}

			this.User_Box.Text = "";

			this.Name_Box.Items.Clear();

			this.Name_Box.Text = "";

			this.Character_List.Text = "";

			this.User_Box.Text = this.Account_List.Text;
		}

		private void User_Box_TextChanged(object sender, EventArgs e)
		{
			if (this.User_Box.Text == "")
			{
				return;
			}

			this.Name_Box.Items.Clear();

			this.Name_Box.Text = "";

			string query = null;

			try
			{
				query = $"SELECT GameID1, GameID2, GameID3, GameID4, GameID5, GameIDC FROM AccountCharacter WHERE Id = '{this.User_Box.Text}'";

			#if MYSQL
				MySqlDataReader reader = new MySqlCommand(query, Import.Mu_Connection).ExecuteReader();
			#else
				OleDbDataReader reader = new OleDbCommand(query, Import.Mu_Connection).ExecuteReader();
			#endif

				if (reader.Read())
				{
					string value = null;

					for (int i = 0; i < 5; i++)
					{
						value = Convert.ToString(reader.GetValue(i));

						if (value != "")
						{
							this.Name_Box.Items.Add(value);
						}
					}

					this.Character_Info_Box.Enabled = false;

					value = Convert.ToString(reader.GetValue(5));

					if (value != "")
					{
						this.lastCharacter_value.Text = value;
					}
					else
					{
						this.lastCharacter_value.Text = "NO INFO";
					}
				}

				reader.Close();

				query = $"SELECT ServerName, ConnectStat, IP, ConnectTM, DisConnectTM from MEMB_STAT WHERE memb___id= '{this.User_Box.Text}'";

			#if MYSQL
				reader = new MySqlCommand(query, Import.Mu_Connection).ExecuteReader();
			#else
				reader = new OleDbCommand(query, Import.Mu_Connection).ExecuteReader();
			#endif

				if (reader.Read())
				{
					this.Server_value.Text = Convert.ToString(reader.GetValue(0));

					int Online = reader.GetByte(1);

					this.Acc_Status_value.Text = (Online == 1) ? "ONLINE" : "OFFLINE";

					this.Acc_Status_value.ForeColor = (Online == 1) ? Color.Green : Color.Red;

					this.IP_value.Text = Convert.ToString(reader.GetValue(2));

					this.lastOnline_value.Text = Convert.ToString(reader.GetValue(3));

					this.lastOffline_value.Text = Convert.ToString(reader.GetValue(4));
				}
				else
				{
					this.Server_value.Text = "NO INFO";

					this.Acc_Status_value.Text = "OFFLINE";

					this.Acc_Status_value.ForeColor = Color.Red;

					this.IP_value.Text = "NO INFO";

					this.lastOnline_value.Text = "NO INFO";

					this.lastOffline_value.Text = "NO INFO";
				}

				reader.Close();

				query = $"SELECT memb__pwd, sno__numb, AccountLevel, AccountExpireDate, bloc_code, Bloc_Expire from MEMB_INFO WHERE memb___id = '{this.User_Box.Text}'";

			#if MYSQL
				reader = new MySqlCommand(query, Import.Me_Connection).ExecuteReader();
			#else
				reader = new OleDbCommand(query, Import.Me_Connection).ExecuteReader();
			#endif

				if (reader.Read())
				{
					this.Pass_Box.Text = Convert.ToString(reader.GetValue(0));

					this.Code_Box.Text = Convert.ToString(reader.GetValue(1));

					this.Vip_Level.Value = reader.GetInt32(2);

					this.Vip_Date.Value = reader.GetDateTime(3);

					string ban = Convert.ToString(reader.GetValue(4));
					this.Ban_Box.Checked = ban == "1";

					this.Ban_Date.Value = reader.GetDateTime(5);
				}

				reader.Close();

				this.Account_Info_Box.Enabled = true;

				if (this.Name_Box.Items.Count < Import.MaxAccountCharacter)
				{
					this.Btn_CreateCharacter.Enabled = true;
				}

				if (this.Name_Box.Items.Contains(this.Character_List.Text))
				{
					this.Name_Box.SelectedIndex = this.Name_Box.Items.IndexOf(this.Character_List.Text);
				}
			}
			catch (Exception exception)
			{
				MessageBox.Show($"[SQL] {query}\n[Error] {exception.Message}\n[Source] {exception.Source}\n[Trace] {exception.StackTrace}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void Btn_Acc_Apply_Click(object sender, EventArgs e)
		{
			if (Import.Me_Connection.State != ConnectionState.Open)
			{
				return;
			}

			string query = null;

			try
			{
				if (!Validator.PassWord(this.Pass_Box.Text.Trim()))
				{
					MessageBox.Show("$Error: Passwords must be between 4-10 characters.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else if (!Validator.Number(this.Code_Box.Text.Trim()))
				{
					MessageBox.Show("$Error: Code must be 18 numbers only.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else if (this.Code_Box.Text.Length < 18)
				{
					MessageBox.Show("$Error: Code must be 18 numbers only.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else
				{
					query = $"SELECT ConnectStat FROM MEMB_STAT WHERE memb___id = '{this.User_Box.Text.Trim()}'";

				#if MYSQL
					MySqlDataReader reader = new MySqlCommand(query, Import.Me_Connection).ExecuteReader();
				#else
					OleDbDataReader reader = new OleDbCommand(query, Import.Me_Connection).ExecuteReader();
				#endif

					if (reader.Read())
					{
						int Connected = reader.GetByte(0);

						if (Connected == 1)
						{
							MessageBox.Show("$Error: Account must be disconnected. Disconnect account or login with another and reload", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);

							reader.Close();

							return;
						}
					}

					reader.Close();

					query = $"UPDATE MEMB_INFO SET memb__pwd = '{this.Pass_Box.Text.Trim()}', sno__numb = '{this.Code_Box.Text.Trim()}', AccountLevel = {this.Vip_Level.Value}, AccountExpireDate = '{this.Vip_Date.Value.ToString("yyyy-MM-ddTHH:mm:ss")}', bloc_code = {(!this.Ban_Box.Checked ? '0' : '1')}, Bloc_Expire = '{this.Ban_Date.Value.ToString("yyyy-MM-ddTHH:mm:ss")}' WHERE (memb___id = '{this.User_Box.Text.Trim()}')";

					if (MuOnline.Me_ExecuteSQL(query))
					{
						MessageBox.Show($"Account updated.", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
					}
					else
					{
						MessageBox.Show($"Error: Account update failed.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
					}
				}
			}
			catch (Exception exception)
			{
				MessageBox.Show($"[SQL] {query}\n[Error] {exception.Message}\n[Source] {exception.Source}\n[Trace] {exception.StackTrace}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void Character_List_TextChanged(object sender, EventArgs e)
		{
			this.Character_Info_Box.Enabled = false;

			this.Btn_CreateCharacter.Enabled = false;

			this.Account_Info_Box.Enabled = false;
		}

		private void Character_List_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (Import.Mu_Connection.State != ConnectionState.Open)
			{
				return;
			}

			this.Account_List.Text = "";

			this.User_Box.Text = "";

			string query = null;

			try
			{
				query = $"SELECT AccountID FROM \"Character\" WHERE Name = '{this.Character_List.Text}'";

			#if MYSQL
				MySqlDataReader reader = new MySqlCommand(query, Import.Mu_Connection).ExecuteReader();
			#else
				OleDbDataReader reader = new OleDbCommand(query, Import.Mu_Connection).ExecuteReader();
			#endif

				string account = "";

				if (reader.Read())
				{
					account = reader.GetString(0);
				}

				reader.Close();

				this.User_Box.Text = account;
			}
			catch (Exception exception)
			{
				MessageBox.Show($"[SQL] {query}\n[Error] {exception.Message}\n[Source] {exception.Source}\n[Trace] {exception.StackTrace}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void Name_Box_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (Import.Mu_Connection.State != ConnectionState.Open)
			{
				return;
			}

			this.Class_Box.DataSource = new BindingSource(Import.Classes, null);
			this.Class_Box.DisplayMember = "Value";
			this.Class_Box.ValueMember = "Key";

			this.Type_Box.DataSource = new BindingSource(Import.Types, null);
			this.Type_Box.DisplayMember = "Value";
			this.Type_Box.ValueMember = "Key";

			this.Map_Box.DataSource = new BindingSource(Import.Maps, null);
			this.Map_Box.DisplayMember = "Value";
			this.Map_Box.ValueMember = "Key";

			string query = null;

			try
			{
				query = $"SELECT cLevel, ResetCount, GrandResetCount, Class, CtlCode, LevelUpPoint, Strength, Dexterity, Vitality, Energy, MapNumber, MapPosX, MapPosY FROM \"Character\" WHERE Name = '{this.Name_Box.Text}'";

			#if MYSQL
				MySqlDataReader reader = new MySqlCommand(query, Import.Mu_Connection).ExecuteReader();
			#else
				OleDbDataReader reader = new OleDbCommand(query, Import.Mu_Connection).ExecuteReader();
			#endif

				if (reader.Read())
				{
					this.Level_Box.Value = reader.GetInt32(0);

					this.Reset_Box.Text = Convert.ToString(reader.GetInt32(1));

					this.GrandReset_Box.Text = Convert.ToString(reader.GetInt32(2));

					int Var = reader.GetByte(3);
					this.Class_Box.SelectedValue = (Import.Classes.ContainsKey(Var) ? Var : -1);

					Var = reader.GetByte(4);
					this.Type_Box.SelectedValue = (Import.Types.ContainsKey(Var) ? Var : 0);

					this.Point_Box.Text = Convert.ToString(reader.GetInt32(5));

					this.Strength_Box.Text = Convert.ToString(reader.GetInt32(6));

					this.Dexterity_Box.Text = Convert.ToString(reader.GetInt32(7));

					this.Vitality_Box.Text = Convert.ToString(reader.GetInt32(8));

					this.Energy_Box.Text = Convert.ToString(reader.GetInt32(9));

					Var = reader.GetByte(10);
					this.Map_Box.SelectedValue = (Import.Maps.ContainsKey(Var) ? Var : -1);

					this.PosX_Box.Text = Convert.ToString(reader.GetByte(11));

					this.PosY_Box.Text = Convert.ToString(reader.GetByte(12));
				}

				reader.Close();

				this.Character_Info_Box.Enabled = true;
			}
			catch (Exception exception)
			{
				MessageBox.Show($"[SQL] {query}\n[Error] {exception.Message}\n[Source] {exception.Source}\n[Trace] {exception.StackTrace}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void Btn_CreateCharacter_Click(object sender, EventArgs e)
		{
			this.Opacity = 0.0d;

			CharacterManager characterManager = new CharacterManager(this.User_Box.Text);

			characterManager.ShowDialog();

			characterManager.Dispose();

			this.LoadCharacters();

			string account = this.User_Box.Text;

			this.User_Box.Text = "";

			this.User_Box.Text = account;

			this.Opacity = 1.0d;
		}

		private void Btn_Char_Apply_Click(object sender, EventArgs e)
		{
			if (Import.Mu_Connection.State != ConnectionState.Open || Import.Me_Connection.State != ConnectionState.Open)
			{
				return;
			}

			string query = null;

			try
			{
				if (!Validator.Number(this.Reset_Box.Text.Trim()))
				{
					MessageBox.Show($"Error: Reset must be numbers only.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else if (!Validator.Number(this.GrandReset_Box.Text.Trim()))
				{
					MessageBox.Show($"Error: GrandReset must be numbers only.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else if (!Validator.Number(this.Point_Box.Text.Trim()))
				{
					MessageBox.Show($"Error: Points must be numbers only.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else if (!Validator.Number(this.Strength_Box.Text.Trim()))
				{
					MessageBox.Show($"Error: Strength must be numbers only.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else if (!Validator.Number(this.Dexterity_Box.Text.Trim()))
				{
					MessageBox.Show($"Error: Dexterity must be numbers only.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else if (!Validator.Number(this.Vitality_Box.Text.Trim()))
				{
					MessageBox.Show($"Error: Vitality must be numbers only.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else if (!Validator.Number(this.Energy_Box.Text.Trim()))
				{
					MessageBox.Show($"Error: Energy must be numbers only.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else if (!Validator.Number(this.PosX_Box.Text.Trim()))
				{
					MessageBox.Show($"Error: Position X must be numbers only.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else if (!Validator.Number(this.PosY_Box.Text.Trim()))
				{
					MessageBox.Show($"Error: Position Y must be numbers only.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else if (Convert.ToString(this.Class_Box.SelectedValue) == "-1")
				{
					MessageBox.Show($"Error: Class UNKNOWN. Select a valid Class or modify Data/classes.txt", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else if (Convert.ToString(this.Map_Box.SelectedValue) == "-1")
				{
					MessageBox.Show($"Error: Map UNKNOWN. Select a valid Map or modify Data/maps.txt", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
				else
				{
					query = $"SELECT ConnectStat FROM MEMB_STAT WHERE memb___id = '{this.User_Box.Text.Trim()}'";

				#if MYSQL
					MySqlDataReader reader = new MySqlCommand(query, Import.Me_Connection).ExecuteReader();
				#else
					OleDbDataReader reader = new OleDbCommand(query, Import.Me_Connection).ExecuteReader();
				#endif

					if (reader.Read())
					{
						int Connected = reader.GetByte(0);

						if (Connected == 1)
						{
							MessageBox.Show($"Error: Account must be disconnected. Disconnect account or login with another and reload", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);

							reader.Close();

							return;
						}
					}

					reader.Close();

					query = $"UPDATE \"Character\" SET cLevel = {this.Level_Box.Value}, ResetCount = {this.Reset_Box.Text.Trim()}, GrandResetCount = {this.GrandReset_Box.Text.Trim()}, Class = {this.Class_Box.SelectedValue}, CtlCode = {this.Type_Box.SelectedValue}, LevelUpPoint = {this.Point_Box.Text.Trim()}, Strength = {this.Strength_Box.Text.Trim()}, Dexterity = {this.Dexterity_Box.Text.Trim()}, Vitality = {this.Vitality_Box.Text.Trim()}, Energy = {this.Energy_Box.Text.Trim()}, MapNumber = {this.Map_Box.SelectedValue}, MapPosX = {this.PosX_Box.Text.Trim()}, MapPosY = {this.PosY_Box.Text.Trim()} WHERE AccountID = '{this.User_Box.Text.Trim()}' AND Name = '{this.Name_Box.Text.Trim()}'";

					if (MuOnline.Mu_ExecuteSQL(query))
					{
						MessageBox.Show($"Character updated.", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
					}
					else
					{
						MessageBox.Show($"Error: Character update failed.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
					}
				}
			}
			catch (Exception exception)
			{
				MessageBox.Show($"[SQL] {query}\n[Error] {exception.Message}\n[Source] {exception.Source}\n[Trace] {exception.StackTrace}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void Btn_Vault_Edit_Click(object sender, EventArgs e)
		{
			this.Opacity = 0.0d;

			Warehouse warehouseEditor = new Warehouse(this.User_Box.Text);

			warehouseEditor.ShowDialog();

			warehouseEditor.Dispose();

			this.Opacity = 1.0d;
		}

		private void Btn_Inventory_Edit_Click(object sender, EventArgs e)
		{
			this.Opacity = 0.0d;

			Inventory inventoryEditor = new Inventory(this.User_Box.Text, this.Name_Box.Text);

			inventoryEditor.ShowDialog();

			inventoryEditor.Dispose();

			this.Opacity = 1.0d;
		}
	}
}