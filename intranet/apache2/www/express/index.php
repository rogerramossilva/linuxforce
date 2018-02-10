<?php
require('header.php');
?>
	<div id="grid_content">
		<div class="main_content">
			<?php require('menu.php'); ?>
			<h1>Controle de Pedidos</h1>
			<table cellpadding="0" cellspacing="0" border="0" class="tabela">
				<thead>
					<tr>
						<th></th>
						<th>Pedido</th>
						<th>Cliente</th>
						<th>Telefone</th>
						<th>Coleta</th>
						<th>Valor</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" /></td>
						<td>1994</td>
						<td><a href="allsafe.php">Allsafe</a></td>
						<td>+1 256-512-1024</td>
						<td>Planilhas</td>
						<td>175.35</td>
						<td>Aguardando carro</td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>1995</td>
						<td><a href="ecorp.php">E-CORP</a></td>
						<td>+1 512-128-3072</td>
						<td>LTO</td>
						<td>2500.00</td>
						<td>Em transito</td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>1996</td>
						<td><a href="ecorp.php">E-CORP</a></td>
						<td>+1 512-128-3072</td>
						<td>LTO</td>
						<td>2500.00</td>
						<td>Aguardando carro</td>
					</tr>
				</tbody>
			</table>
		</div>
		
<?php require('sidebar.php'); ?>
</div>

<?php
require('footer.php');
?>
