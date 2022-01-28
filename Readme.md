*Projeto Laboratório terraform.*

  -Perfil Traffic Manager 
  -Roteamento por desempenho, ponto final "mais próximo" para a menor latência da rede..
  -Dois endpoints: 
    -Load Balancer no Brasil
      -Backend - Virtual Machine scale set
    -Load Balancer no Oeste da Europa
      -Backend - Virtual Machine scale set

 Obs.: O arquivo de  estado do terraform (terraform.fstate) está sendo salvo em storage account no Azure.  
