<?php
require('header.php');
?>
	<div id="grid_content">
		<div class="main_content">
			<?php require('menu.php'); ?>
			<h1>Lista de Clientes</h1>
			<table cellpadding="0" cellspacing="0" border="0" class="tabela">
				<thead>
					<tr>
						<th></th>
						<th>ID</th>
						<th>Cliente</th>
						<th>Telefone</th>
						<th>Respons&aacute;vel</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" /></td>
						<td>001</td>
						<td><a href="allsafe.php">Allsafe</a></td>
						<td>+1 256-512-1024</td>
						<td>Gideon Goddard</td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>002</td>
						<td><a href="ecorp.php">E-CORP</a></td>
						<td>+1 512-128-3072</td>
						<td>Phillip Price</td>
					</tr>
				</tbody>
			</table>
		</div>
		
<?php require('sidebar.php'); ?>
</div>

<?php
require('footer.php');
?>
