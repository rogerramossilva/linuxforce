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
						<label>Empresa: </label><input type="text" size="30" value="E-CORP."/>
					</p>
					<p>
						<label>Telefone: </label><input type="text" size="30" value="+1 512-128-3072" />
					</p>
					<p>
						<label>Endereço: </label><input type="text" size="30"  value="Steel Mountain" />
					</p>
					<p>
						<label>CEP: </label><input type="text" size="30" value="83716"/>
					</p>
				</div>
				<div class="fright">
					<p>
						<label>Responsável: </label><input type="text" size="30" value="Phillip Price" />
					</p>
					<p>
						<label>Bairro: </label><input type="text" size="30" value="Centre" />
					</p>
					<p>
						<label>Cidade: </label><input type="text" size="30" value="Idaho"/>
					</p>
					<p>
						<label>Estado: </label><input type="text" size="30"  value="Idaho"/>
					</p>
				</div>
				<h1>Informações</h1>
				<div id="dadoscliente">
					<ul>
						<li><a href="#tabs-2">Coletas</a></li>
						<li><a href="#tabs-1">Histórico</a></li>
					</ul>
					<div id="tabs-1" class="notes">
						<p> Coleta Nº 1995 Em transito</p>
						<p> Coleta Nº 1996 Agurando carro</p>
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
									<td>1995</td>
									<td>LTO</td>
									<td>Em transito</td>
									<td>Tyrell Wellic</td>
								</tr>
								<tr>
									<td>1996</td>
									<td>LTO</td>
									<td>Aguardando carro</td>
									<td>Tyrell Wellic</td>
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
