// Função Responsavel pelo cache

    function GeraCache(){
        return new Promise((resolve, reject)=>{
            var leading = {
                nome: null,
                cpf_cnpj: null,
                email: null,
                telefone: null,
                cep: null,
                bairro: null,
                cidade: null,
                uf: null,
                logradouro: null,
                numero: null,
                ip: null,
                navegou_site: null,
                navegou_contato: null,
                navegou_hospedagem: null
            };
    
            var servicos = {};
    
            var ordem_servico = {};
    
            if(!localStorage.getItem("SOSHospedagens-Leading")){ localStorage.setItem("SOSHospedagens-Leading", JSON.stringify(leading)) };
            if(!localStorage.getItem("SOSHospedagens-Servicos")){ localStorage.setItem("SOSHospedagens-Servicos", JSON.stringify(servicos)) };
            if(!localStorage.getItem("SOSHospedagens-OrdemServico")){ localStorage.setItem("SOSHospedagens-OrdemServico", JSON.stringify(ordem_servico)) };

            resolve();
        })

    }

// Gerenciamento da Página

    // Gerencia os processo após carregar a pagina

    $(document).ready(()=>{
        GeraCache().then((data)=>{
            var cache_leading = JSON.parse(localStorage.getItem("SOSHospedagens-Leading"));
            cache_leading.ip = $("input[name='input-ip']").val();
            cache_leading.navegou_site = true;
            localStorage.setItem("SOSHospedagens-Leading", JSON.stringify(cache_leading));
        });
    });

    // Seta no Leading o Status de navegou_hospedagem

    $(document).on('click', '#btn-selecionar-hospedagem', (evento)=>{
        var cache_leading = JSON.parse(localStorage.getItem("SOSHospedagens-Leading"));
        cache_leading.navegou_hospedagem = true;
        localStorage.setItem("SOSHospedagens-Leading", JSON.stringify(cache_leading));
    });