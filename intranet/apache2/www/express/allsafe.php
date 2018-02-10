<?php
require('header.php');
?>    
	<div id="grid_content">
		<div class="main_content">
			<?php require('menu.php'); ?>
			<h1>Dados do cliente</h1>
			<form id="cliente">
				<div class="fleft">
					<p>
						<label>Empresa: </label><input type="text" size="30" value="Allsafe Cybersecurity."/>
					</p>
					<p>
						<label>Telefone: </label><input type="text" size="30" value="+1 256-512-1024" />
					</p>
					<p>
						<label>Endereço: </label><input type="text" size="30"  value="256 Fifth Avenue" />
					</p>
					<p>
						<label>CEP: </label><input type="text" size="30" value="1024"/>
					</p>
				</div>
				<div class="fright">
					<p>
						<label>Responsável: </label><input type="text" size="30" value="Gideon Goodard" />
					</p>
					<p>
						<label>Bairro: </label><input type="text" size="30" value="Centre" />
					</p>
					<p>
						<label>Cidade: </label><input type="text" size="30" value="New York"/>
					</p>
					<p>
						<label>Estado: </label><input type="text" size="30"  value="NY"/>
					</p>
				</div>
				<h1>Informações</h1>
				<div id="dadoscliente">
					<ul>
						<li><a href="#tabs-2">Coletas</a></li>
						<li><a href="#tabs-1">Histórico</a></li>
					</ul>
					<div id="tabs-1" class="notes">
						<p> Coleta Nº 1991 realizada em 21/09/2017 as 09h30</p>
						<p> Coleta Nº 1992 realizada em 22/10/2017 as 09h45</p>
						<p> Coleta Nº 1993 realizada em 21/11/2017 as 12h05</p>
						<p> Coleta Nº 1994 realizada em 21/12/2017 as 11h00</p>
					</div>
					<div id="tabs-2">
						<table cellpadding="0" cellspacing="0" border="0" class="tabela">
							<thead>
								<tr>
									<th>Pedido</th>
									<th>Coleta</th>
									<th>Entrega</th>
									<th>Observação</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1991</td>
									<td>Relatorio</td>
									<td>Entregue - 21/09/2017</td>
									<td>Giddeon</td>
								</tr>
								<tr>
									<td>1992</td>
									<td>Relatorio</td>
									<td>Entregue - 22/10/2017</td>
									<td>Angela</td>
								</tr>
								<tr>
									<td>1993</td>
									<td>Planilha</td>
									<td>Entregue - 21/11/2017</td>
									<td>Angela</td>
								</tr>
							</tbody>
						</table>
						<input type="submit" value="Nova Coleta" />
					</div>
				</div>
				<br />
			</form>
		</div>
		
<?php require('sidebar.php'); ?>
</div>

<?php
require('footer.php');
?>
