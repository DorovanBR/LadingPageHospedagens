// Função Responsavel pelo cache

    function GeraCache(){
        return new Promise((resolve, reject)=>{
            var leading = {
                codigo: null,
                servico: null,
                data_vencimento: null,
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

// Função Responsavel pela Consultda dos Serviços

    function ConsultaServicos(){
        $.ajax({
            type: "POST",
            dataType: "html",
            headers: {
                Authorization : "Sessao.AppToken"
            },
            data: {
                Funcao : 4
            },
            url: 'api/servicos.asp',
            error: function(erro) {
                console.error(erro);
            },		
            success: function(retorno) {
                retorno = jQuery.parseJSON(retorno);
                
                var cache_servicos = JSON.parse(localStorage.getItem("SOSHospedagens-Servicos"));
                cache_servicos = retorno.Requisicao.Retorno.Servicos;

                localStorage.setItem("SOSHospedagens-Servicos", JSON.stringify(cache_servicos));

                $("#Servicos-Registros").html("");

                for(var i=0; i < retorno.Requisicao.Retorno.Servicos.length; i++){
                    var Registro = retorno.Requisicao.Retorno.Servicos[i];

                    var linhaHtml = "<li class='col-4-12 ae-3'>";
                    linhaHtml += "<h3>"+Registro.Nome+"</h3>";
                    linhaHtml += "<div class='price ae-5'><span class='currency'>R$</span>"+Registro.Valor+"</div>";
                    linhaHtml += "<div class='margin-top-3 margin-bottom-3 equalElement ae-6'>";
                    linhaHtml += "<ul class='p tiny'>";
                    linhaHtml += "<li class='opacity-7'>"+Registro.Descricao+"</li>";
                    linhaHtml += "</ul>";
                    linhaHtml += "</div>";
                    linhaHtml += "<a href='javascript:false;' id='btn-selecionar-hospedagem' data-servico='"+Registro.Codigo+"' class='button blue gradient wide cropSides cropBottom ae-7'>Contrate</a>";
                    linhaHtml += "</li>";

                    $("#Servicos-Registros").html($("#Servicos-Registros").html()+linhaHtml);
                }
            }
        });
    }

// Gerenciamento da Página

    // Gerencia os processo após carregar a pagina

    $(document).ready(()=>{
        GeraCache().then((data)=>{
            ConsultaServicos();

            renderizaModal("#modal_cad_ordem_servico", "<span class='text-muted'><i class='fa fa-plus'></i> Checkout de Pedido</span>", {width: 600});
            renderizaModal("#modal_cad_contato", "<span class='text-muted'><i class='fa fa-comments'></i> Formulário de Contato</span>", {width: 600});

            var options = {
                onKeyPress: function (cpf, ev, el, op) {
                    var masks = ['000.000.000-000', '00.000.000/0000-00'];
                    $("input[name='modal_cad_servico_input_CpfCnpj']").mask((cpf.length > 14) ? masks[1] : masks[0], op);
                }
            }
            
            $("input[name='modal_cad_servico_input_CpfCnpj']").length > 11 ? $("input[name='modal_cad_servico_input_CpfCnpj']").mask('00.000.000/0000-00', options) : $("input[name='modal_cad_servico_input_CpfCnpj']").mask('000.000.000-00#', options);

            $("input[name='modal_cad_servico_input_Telefone']").mask(SPMaskBehavior, spOptions);
            $("input[name='modal_cad_servico_input_CEP']").mask("00000-000");

            var cache_leading = JSON.parse(localStorage.getItem("SOSHospedagens-Leading"));
            cache_leading.ip = $("input[name='input-ip']").val();
            cache_leading.navegou_site = true;

            if(cache_leading.codigo == null){
                $.ajax({
                    type: "POST",
                    dataType: "html",
                    async: false,
                    headers: {
                        Authorization : "Sessao.AppToken"
                    },
                    data: {
                        Funcao : 1,
                        'IP' : cache_leading.ip,
                        'CpfCnpj': cache_leading.cpf_cnpj,
                        'Nome': cache_leading.nome,
                        'Email': cache_leading.email,
                        'Telefone': cache_leading.telefone,
                        'Cep': cache_leading.cep,
                        'Bairro': cache_leading.bairro,
                        'Cidade': cache_leading.cidade,
                        'UF': cache_leading.uf,
                        'Logradouro': cache_leading.logradouro,
                        'Numero': cache_leading.numero,
                        'NavegouSite': cache_leading.navegou_site ? 1 : 0,
                        'NavegouContato': cache_leading.navegou_contato ? 1 : 0,
                        'NavegouHospedagem': cache_leading.navegou_hospedagem ? 1 : 0
                    },
                    url: 'api/leadings.asp',
                    error: function(erro) {
                        console.error(erro);
                    },		
                    success: function(retorno) {
                        retorno = jQuery.parseJSON(retorno);
                        cache_leading.codigo = retorno.Requisicao.Retorno.Leading;
                    }
                });
            } else {
                $.ajax({
                    type: "POST",
                    dataType: "html",
                    async: false,
                    headers: {
                        Authorization : "Sessao.AppToken"
                    },
                    data: {
                        Funcao : 2,
                        'IP' : cache_leading.ip,
                        'Codigo': cache_leading.codigo,
                        'CpfCnpj': cache_leading.cpf_cnpj,
                        'Nome': cache_leading.nome,
                        'Email': cache_leading.email,
                        'Telefone': cache_leading.telefone,
                        'Cep': cache_leading.cep,
                        'Bairro': cache_leading.bairro,
                        'Cidade': cache_leading.cidade,
                        'UF': cache_leading.uf,
                        'Logradouro': cache_leading.logradouro,
                        'Numero': cache_leading.numero,
                        'NavegouSite': cache_leading.navegou_site ? 1 : 0,
                        'NavegouContato': cache_leading.navegou_contato ? 1 : 0,
                        'NavegouHospedagem': cache_leading.navegou_hospedagem ? 1 : 0
                    },
                    url: 'api/leadings.asp',
                    error: function(erro) {
                        console.error(erro);
                    },		
                    success: function(retorno) {
                        console.log(retorno);
                    }
                });
            }

            localStorage.setItem("SOSHospedagens-Leading", JSON.stringify(cache_leading));
        });
    });

    // Seta no Leading o Status de navegou_hospedagem

    $(document).on('click', '#btn-selecionar-hospedagem', (evento)=>{
        
        // Declara as Variaveis
        
            var botao = $(evento.currentTarget);

        // Pega o Cache do Leading

            var cache_leading = JSON.parse(localStorage.getItem("SOSHospedagens-Leading"));

        // Trata a Data de Vencimento

            var data_vencimento = new Date();
                data_vencimento.setDate(data_vencimento.getDate() + 5);

            var dia_vecimento = (data_vencimento.getDate() < 10 ? '0' + data_vencimento.getDate() : data_vencimento.getDate());
            var mes_vecimento = (data_vencimento.getMonth() < 9 ? '0' + (data_vencimento.getMonth()+1) : data_vencimento.getMonth()+1);
            var ano_vecimento = data_vencimento.getFullYear();

        // Seta e grava as Informações do Leading no cache

            cache_leading.servico = botao.attr("data-servico");
            cache_leading.data_vencimento = ano_vecimento + '-' + mes_vecimento + '-' + dia_vecimento;
            cache_leading.navegou_hospedagem = true;

            localStorage.setItem("SOSHospedagens-Leading", JSON.stringify(cache_leading));

        // Define os valores dos campos

            $("input[name='input-servico']").val(botao.attr("data-servico"));
            $("input[name='modal_cad_servico_input_Nome']").val(cache_leading.nome != null ? cache_leading.nome : "");
            $("input[name='modal_cad_servico_input_CpfCnpj']").val(cache_leading.cpf_cnpj != null ? cache_leading.cpf_cnpj : "");
            $("input[name='modal_cad_servico_input_Email']").val(cache_leading.email != null ? cache_leading.email : "");
            $("input[name='modal_cad_servico_input_Telefone']").val(cache_leading.telefone != null ? cache_leading.telefone : "");
            $("input[name='modal_cad_servico_input_CEP']").val(cache_leading.cep != null ? cache_leading.cep : "");
            $("input[name='modal_cad_servico_input_Cidade']").val(cache_leading.cidade != null ? cache_leading.cidade : "");
            $("input[name='modal_cad_servico_input_Bairro']").val(cache_leading.bairro != null ? cache_leading.bairro : "");
            $("input[name='modal_cad_servico_input_UF']").val(cache_leading.uf != null ? cache_leading.uf : "");
            $("input[name='modal_cad_servico_input_Logradouro']").val(cache_leading.logradouro != null ? cache_leading.logradouro : "");
            $("input[name='modal_cad_servico_input_Numero']").val(cache_leading.numero != null ? cache_leading.numero : "");

        // Abre a Modal

            abriraModal("#modal_cad_ordem_servico");

    });

    // Valida o campo modal_cad_servico_input_Nome

    $(document).on('change', "input[name='modal_cad_servico_input_Nome']", (evento)=>{
        var statusModal = $("#modal_cad_ordem_servico").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var Nome = $(evento.currentTarget);

            // Valida o Campo
                if(Nome.val() != "" && Nome.val() != " " && Nome.val() != null && Nome.val() != undefined){
                    Nome.addClass("is-valid");
                    Nome.removeClass("is-invalid");
                } else {
                    Nome.addClass("is-invalid");
                    Nome.removeClass("is-valid");
                }
        }

    });

    // Valida o campo modal_cad_servico_input_CpfCnpj

    $(document).on('change', "input[name='modal_cad_servico_input_CpfCnpj']", (evento)=>{
        var statusModal = $("#modal_cad_ordem_servico").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var CpfCnpj = $(evento.currentTarget);

            // Valida o Campo
                if(CpfCnpj.val() != "" && CpfCnpj.val() != " " && CpfCnpj.val() != null && CpfCnpj.val() != undefined && ValidaDocumento((CpfCnpj.val()).length <= 14 ? 1 : 2, CpfCnpj.val())){
                    CpfCnpj.addClass("is-valid");
                    CpfCnpj.removeClass("is-invalid");
                } else {
                    CpfCnpj.addClass("is-invalid");
                    CpfCnpj.removeClass("is-valid");
                }
        }

    });

    // Valida o campo modal_cad_servico_input_Email

    $(document).on('change', "input[name='modal_cad_servico_input_Email']", (evento)=>{
        var statusModal = $("#modal_cad_ordem_servico").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var Email = $(evento.currentTarget);
				var regEmail = /^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?.]+@[a-z0-9]+\.[a-z]+(\.[a-z]+)?$/i;

            // Valida o Campo
                if(Email.val() != "" && Email.val() != " " && Email.val() != null && Email.val() != undefined && regEmail.test(Email.val())){
                    Email.addClass("is-valid");
                    Email.removeClass("is-invalid");
                } else {
                    Email.addClass("is-invalid");
                    Email.removeClass("is-valid");
                }
        }

    });

    // Valida o campo modal_cad_servico_input_Telefone

    $(document).on('change', "input[name='modal_cad_servico_input_Telefone']", (evento)=>{
        var statusModal = $("#modal_cad_ordem_servico").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var Telefone = $(evento.currentTarget);

            // Valida o Campo
                if(Telefone.val() != "" && Telefone.val() != " " && Telefone.val() != null && Telefone.val() != undefined){
                    Telefone.addClass("is-valid");
                    Telefone.removeClass("is-invalid");
                } else {
                    Telefone.addClass("is-invalid");
                    Telefone.removeClass("is-valid");
                }
        }

    });

    // Atualiza os Campos de Acordo com o Cep Preenchido

    $(document).on('change', "input[name='modal_cad_servico_input_CEP']", (evento)=>{

        // Verifica o Status da Modal

            var statusModal = $("#modal_cad_ordem_servico").iziModal("getState");

            if(statusModal == "opened"){

                // Declaração das Variaveis

                    var CEP = $(evento.currentTarget);

                // Realiza a Validação

                    if(CEP.val() != undefined && CEP.val() != null && CEP.val() != "" && CEP.val() != " "){

                        // Remove o Erro do Campo

                            CEP.addClass("is-valid");
                            CEP.removeClass("is-invalid");

                        // Declara as Variaveis

                            var Cidade = $("input[name='modal_cad_servico_input_Cidade']");
                            var UF = $("input[name='modal_cad_servico_input_UF']");
                            var Bairro = $("input[name='modal_cad_servico_input_Bairro']");
                            var Endereco = $("input[name='modal_cad_servico_input_Logradouro']");
                            var ChecaCEP = CEP.val();

                        // Trata o CEP recebido

                            ChecaCEP = ChecaCEP.replace(/\-/g,"");
                            ChecaCEP = ChecaCEP.replace(/\./g,"");

                        // Verifica se o cep possui 8 digitos

                            if(ChecaCEP.length == 8){

                                $.ajax({
                                    type: "get",
                                    dataType: "html",
                                    url: "https://viacep.com.br/ws/"+ChecaCEP+"/json/",
                                    beforeSend: function(data){
                                        swal({
                                            title: 'Consultando CEP',
                                            text: 'Aguarde',
                                            onOpen: () => {
                                                swal.showLoading()
                                            },
                                            allowOutsideClick: false
                                        })
                                    },
                                    error: function(erro) {
                                        var mensagem = null; 
                                        if (erro == "timeout") {				        						
                                            mensagem = 'O Servidor demorou na resposta, tente novamente mais tarde!';
                                        }
                                        else {				        						
                                            mensagem = 'Algo estranho aconteceu, tente novamente mais tarde!';
                                        }
                                        swal.close();
                                        swal({
                                            title: "Ops!",
                                            text: mensagem,
                                            type: "error",
                                            allowOutsideClick: false
                                        })
                                    },		
                                    success: function(retorno) {

                                        // Trata o retorno transformando em array

                                            var CEPArray = jQuery.parseJSON(retorno);

                                        // Define o valor dos campos

                                            Bairro.val(CEPArray.bairro);
                                            Endereco.val(CEPArray.logradouro);
                                            Cidade.val(CEPArray.localidade);
                                            UF.val(CEPArray.uf);

                                        // Fecha o SweetAlert

                                            swal.close();

                                    }
                                });

                            } else {

                                // Exibe Mensagem de Erro

                                    toastr.error('O CEP especificado esta incorreto, verifique e tente novamente', 'Ops!');

                            }
                    } else {
                        CEP.addClass("is-invalid");
                        CEP.removeClass("is-valid");
                    }

            }

    })

    // Valida o campo modal_cad_servico_input_Cidade

    $(document).on('change', "input[name='modal_cad_servico_input_Cidade']", (evento)=>{
        var statusModal = $("#modal_cad_ordem_servico").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var Cidade = $(evento.currentTarget);

            // Valida o Campo
                if(Cidade.val() != "" && Cidade.val() != " " && Cidade.val() != null && Cidade.val() != undefined){
                    Cidade.addClass("is-valid");
                    Cidade.removeClass("is-invalid");
                } else {
                    Cidade.addClass("is-invalid");
                    Cidade.removeClass("is-valid");
                }
        }

    });

    // Valida o campo modal_cad_servico_input_Bairro

    $(document).on('change', "input[name='modal_cad_servico_input_Bairro']", (evento)=>{
        var statusModal = $("#modal_cad_ordem_servico").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var Bairro = $(evento.currentTarget);

            // Valida o Campo
                if(Bairro.val() != "" && Bairro.val() != " " && Bairro.val() != null && Bairro.val() != undefined){
                    Bairro.addClass("is-valid");
                    Bairro.removeClass("is-invalid");
                } else {
                    Bairro.addClass("is-invalid");
                    Bairro.removeClass("is-valid");
                }
        }

    });

    // Valida o campo modal_cad_servico_input_UF

    $(document).on('change', "input[name='modal_cad_servico_input_UF']", (evento)=>{
        var statusModal = $("#modal_cad_ordem_servico").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var UF = $(evento.currentTarget);

            // Valida o Campo
                if(UF.val() != "" && UF.val() != " " && UF.val() != null && UF.val() != undefined){
                    UF.addClass("is-valid");
                    UF.removeClass("is-invalid");
                } else {
                    UF.addClass("is-invalid");
                    UF.removeClass("is-valid");
                }
        }

    });

    // Valida o campo modal_cad_servico_input_Logradouro

    $(document).on('change', "input[name='modal_cad_servico_input_Logradouro']", (evento)=>{
        var statusModal = $("#modal_cad_ordem_servico").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var Logradouro = $(evento.currentTarget);

            // Valida o Campo
                if(Logradouro.val() != "" && Logradouro.val() != " " && Logradouro.val() != null && Logradouro.val() != undefined){
                    Logradouro.addClass("is-valid");
                    Logradouro.removeClass("is-invalid");
                } else {
                    Logradouro.addClass("is-invalid");
                    Logradouro.removeClass("is-valid");
                }
        }

    });

    // Valida o campo modal_cad_servico_input_Numero

    $(document).on('change', "input[name='modal_cad_servico_input_Numero']", (evento)=>{
        var statusModal = $("#modal_cad_ordem_servico").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var Numero = $(evento.currentTarget);

            // Valida o Campo
                if(Numero.val() != "" && Numero.val() != " " && Numero.val() != null && Numero.val() != undefined){
                    Numero.addClass("is-valid");
                    Numero.removeClass("is-invalid");
                } else {
                    Numero.addClass("is-invalid");
                    Numero.removeClass("is-valid");
                }
        }

    });

    // Valida o formulário novamente e finaliza o pedido

    $(document).on('click', "#btn-modal-finalizar-pedido", (evento)=>{

        // Declara as Variaveis

            var cache_leading = JSON.parse(localStorage.getItem("SOSHospedagens-Leading"));
            var Servico = $("input[name='input-servico']");
            var Nome = $("input[name='modal_cad_servico_input_Nome']");
            var CpfCnpj = $("input[name='modal_cad_servico_input_CpfCnpj']");
            var Email = $("input[name='modal_cad_servico_input_Email']");
            var regEmail = /^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?.]+@[a-z0-9]+\.[a-z]+(\.[a-z]+)?$/i; 
            var Telefone = $("input[name='modal_cad_servico_input_Telefone']");
            var Telefone = $("input[name='modal_cad_servico_input_Telefone']");
            var CEP = $("input[name='modal_cad_servico_input_CEP']");
            var Cidade = $("input[name='modal_cad_servico_input_Cidade']");
            var Bairro = $("input[name='modal_cad_servico_input_Bairro']");
            var UF = $("input[name='modal_cad_servico_input_UF']");
            var Logradouro = $("input[name='modal_cad_servico_input_Logradouro']");
            var Numero = $("input[name='modal_cad_servico_input_Numero']");
            var botao = $(evento.currentTarget);

        // Remove todas as Classes

            Nome.removeClass("is-valid").removeClass("is-invalid");
            CpfCnpj.removeClass("is-valid").removeClass("is-invalid");
            Email.removeClass("is-valid").removeClass("is-invalid");
            Telefone.removeClass("is-valid").removeClass("is-invalid");
            Telefone.removeClass("is-valid").removeClass("is-invalid");
            CEP.removeClass("is-valid").removeClass("is-invalid");
            Cidade.removeClass("is-valid").removeClass("is-invalid");
            Bairro.removeClass("is-valid").removeClass("is-invalid");
            UF.removeClass("is-valid").removeClass("is-invalid");
            Logradouro.removeClass("is-valid").removeClass("is-invalid");
            Numero.removeClass("is-valid").removeClass("is-invalid");

        // Valida os Campos do Formulário

            var validacao = []
                validacao[0] = Nome.val() != "" && Nome.val() != " " && Nome.val() != null && Nome.val() != undefined;
                validacao[1] = CpfCnpj.val() != "" && CpfCnpj.val() != " " && CpfCnpj.val() != null && CpfCnpj.val() != undefined && ValidaDocumento((CpfCnpj.val()).length <= 14 ? 1 : 2, CpfCnpj.val());
                validacao[2] = Email.val() != "" && Email.val() != " " && Email.val() != null && Email.val() != undefined && regEmail.test(Email.val());
                validacao[3] = Telefone.val() != "" && Telefone.val() != " " && Telefone.val() != null && Telefone.val() != undefined;
                validacao[4] = CEP.val() != undefined && CEP.val() != null && CEP.val() != "" && CEP.val() != " ";
                validacao[5] = Cidade.val() != "" && Cidade.val() != " " && Cidade.val() != null && Cidade.val() != undefined;
                validacao[6] = Bairro.val() != "" && Bairro.val() != " " && Bairro.val() != null && Bairro.val() != undefined;
                validacao[7] = UF.val() != "" && UF.val() != " " && UF.val() != null && UF.val() != undefined;
                validacao[8] = Logradouro.val() != "" && Logradouro.val() != " " && Logradouro.val() != null && Logradouro.val() != undefined;
                validacao[9] = Numero.val() != "" && Numero.val() != " " && Numero.val() != null && Numero.val() != undefined;

            var checaValidacao = validacao[0] && validacao[1] && validacao[2] && validacao[3] && validacao[4] && validacao[5] && validacao[6] && validacao[7] && validacao[8] && validacao[9];

        // Verifica se a Validação esta correta e caso sim prossegue com a atualização do Leading

            if(checaValidacao){

                // Adiciona o estilo de campo correto

                    Nome.addClass("is-valid");
                    CpfCnpj.addClass("is-valid");
                    Email.addClass("is-valid");
                    Telefone.addClass("is-valid");
                    Telefone.addClass("is-valid");
                    CEP.addClass("is-valid");
                    Cidade.addClass("is-valid");
                    Bairro.addClass("is-valid");
                    UF.addClass("is-valid");
                    Logradouro.addClass("is-valid");
                    Numero.addClass("is-valid");

                // Seta e grava os dados do Cache

                    cache_leading.nome = Nome.val();
                    cache_leading.cpf_cnpj = CpfCnpj.val();
                    cache_leading.email = Email.val();
                    cache_leading.telefone = Telefone.val();
                    cache_leading.cep = CEP.val();
                    cache_leading.cidade = Cidade.val();
                    cache_leading.bairro = Bairro.val();
                    cache_leading.uf = UF.val();
                    cache_leading.logradouro = Logradouro.val();
                    cache_leading.numero = Numero.val();

                    localStorage.setItem("SOSHospedagens-Leading", JSON.stringify(cache_leading));

                // Executa o Ajax
                    
                    $.ajax({
                        type: "POST",
                        dataType: "html",
                        headers: {
                            Authorization : "Sessao.AppToken"
                        },
                        data: {
                            Funcao : 2,
                            'IP' : cache_leading.ip,
                            'Codigo': cache_leading.codigo,
                            'CpfCnpj': cache_leading.cpf_cnpj,
                            'Nome': cache_leading.nome,
                            'Email': cache_leading.email,
                            'Telefone': cache_leading.telefone,
                            'Cep': cache_leading.cep,
                            'Bairro': cache_leading.bairro,
                            'Cidade': cache_leading.cidade,
                            'UF': cache_leading.uf,
                            'Logradouro': cache_leading.logradouro,
                            'Numero': cache_leading.numero,
                            'NavegouSite': cache_leading.navegou_site ? 1 : 0,
                            'NavegouContato': cache_leading.navegou_contato ? 1 : 0,
                            'NavegouHospedagem': cache_leading.navegou_hospedagem ? 1 : 0
                        },
                        url: 'api/leadings.asp',
                        beforeSend: function(data){
                            swal({
                                title: 'Enviando os Seus Dados',
                                text: 'Aguarde',
                                onOpen: () => {
                                    swal.showLoading()
                                },
                                allowOutsideClick: false
                            })
                        },
                        error: function(erro) {
                            var mensagem = null; 
                            if (erro == "timeout") {				        						
                                mensagem = 'O Servidor demorou na resposta, tente novamente mais tarde!';
                            }
                            else {				        						
                                mensagem = 'Algo estranho aconteceu, tente novamente mais tarde!';
                            }
                            swal.close();
                            swal({
                                title: "Ops!",
                                text: mensagem,
                                type: "error",
                                allowOutsideClick: false
                            })
                        },		
                        success: function(retorno) {

                            // Gera a Cobrança
                    
                                $.ajax({
                                    type: "POST",
                                    dataType: "html",
                                    headers: {
                                        Authorization : "Sessao.AppToken"
                                    },
                                    data: {
                                        Funcao : 2,
                                        'Servidor' : 'Homologação',
                                        'Configuracao' : 8,
                                        'Leading': cache_leading.codigo,
                                        'Servico': cache_leading.servico,
                                        'DataVencimento': cache_leading.data_vencimento,
                                        'TiposPagamento': '"BOLETO", "CREDIT_CARD"',
                                    },
                                    url: 'api/juno.asp',
                                    beforeSend: function(data){
                                        swal({
                                            title: 'Gerando Cobrança',
                                            text: 'Aguarde',
                                            onOpen: () => {
                                                swal.showLoading()
                                            },
                                            allowOutsideClick: false
                                        })
                                    },
                                    error: function(erro) {
                                        var mensagem = null; 
                                        if (erro == "timeout") {				        						
                                            mensagem = 'O Servidor demorou na resposta, tente novamente mais tarde!';
                                        }
                                        else {				        						
                                            mensagem = 'Algo estranho aconteceu, tente novamente mais tarde!';
                                        }
                                        swal.close();
                                        swal({
                                            title: "Ops!",
                                            text: mensagem,
                                            type: "error",
                                            allowOutsideClick: false
                                        })
                                    },		
                                    success: function(retorno) {

                                        // Fecha o sweetalert aberto

                                            swal.close();

                                        // Trata o retorno transformando em array

                                            var retorno = jQuery.parseJSON(retorno);
                                        
                                        // Atualiza o Leading com o link de pagamento

                                            let cache_leading = JSON.parse(localStorage.getItem("SOSHospedagens-Leading"));
                                            cache_leading.link_pagamento = retorno.Requisicao.Retorno.LinkPagamento;
                                            localStorage.setItem("SOSHospedagens-Leading", JSON.stringify(cache_leading));

                                        // Envia mensagem de sucesso

                                            swal({
                                                title: retorno.Mensagem.Titulo,
                                                text: retorno.Mensagem.Texto,
                                                type: retorno.Mensagem.Tipo,
                                                allowOutsideClick: false
                                            }).then((data)=>{
                                                window.open(cache_leading.link_pagamento);
                                                fecharModal("#modal_cad_ordem_servico");
                                            })

                                    }
                                });

                        }
                    });

            } else {
                
                // Verifica qual ou quais campos estão com erro

                    if(!validacao[0]){
                        Nome.addClass("is-invalid");
                    }

                    if(!validacao[1]){
                        CpfCnpj.addClass("is-invalid");
                    }

                    if(!validacao[2]){
                        Email.addClass("is-invalid");
                    }

                    if(!validacao[3]){
                        Telefone.addClass("is-invalid");
                    }

                    if(!validacao[4]){
                        CEP.addClass("is-invalid");
                    }

                    if(!validacao[5]){
                        Cidade.addClass("is-invalid");
                    }

                    if(!validacao[6]){
                        Bairro.addClass("is-invalid");
                    }

                    if(!validacao[7]){
                        UF.addClass("is-invalid");
                    }

                    if(!validacao[8]){
                        Logradouro.addClass("is-invalid");
                    }

                    if(!validacao[9]){
                        Numero.addClass("is-invalid");
                    }
            }

    })

    // Realiza os processos de Contato

    $(document).on('click', '#btn-modal-contato', (evento)=>{
        
        // Declara as Variaveis
        
            var botao = $(evento.currentTarget);

        // Pega o Cache do Leading

            var cache_leading = JSON.parse(localStorage.getItem("SOSHospedagens-Leading"));

        // Seta e grava as Informações do Leading no cache

            cache_leading.navegou_contato = true;

            localStorage.setItem("SOSHospedagens-Leading", JSON.stringify(cache_leading));

        // Define os valores dos campos

            $("input[name='modal_cad_contato_input_Nome']").val(cache_leading.nome != null ? cache_leading.nome : "");
            $("input[name='modal_cad_contato_input_Email']").val(cache_leading.email != null ? cache_leading.email : "");
            $("input[name='modal_cad_contato_input_Telefone']").val(cache_leading.telefone != null ? cache_leading.telefone : "");

        // Abre a Modal

            abriraModal("#modal_cad_contato");

    });

    // Valida o campo modal_cad_contato_input_Nome

    $(document).on('change', "input[name='modal_cad_contato_input_Nome']", (evento)=>{
        var statusModal = $("#modal_cad_contato").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var Nome = $(evento.currentTarget);

            // Valida o Campo
                if(Nome.val() != "" && Nome.val() != " " && Nome.val() != null && Nome.val() != undefined){
                    Nome.addClass("is-valid");
                    Nome.removeClass("is-invalid");
                } else {
                    Nome.addClass("is-invalid");
                    Nome.removeClass("is-valid");
                }
        }

    });

    // Valida o campo modal_cad_contato_input_Telefone

    $(document).on('change', "input[name='modal_cad_contato_input_Telefone']", (evento)=>{
        var statusModal = $("#modal_cad_contato").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var Telefone = $(evento.currentTarget);

            // Valida o Campo
                if(Telefone.val() != "" && Telefone.val() != " " && Telefone.val() != null && Telefone.val() != undefined){
                    Telefone.addClass("is-valid");
                    Telefone.removeClass("is-invalid");
                } else {
                    Telefone.addClass("is-invalid");
                    Telefone.removeClass("is-valid");
                }
        }

    });

    // Valida o campo modal_cad_contato_input_Email

    $(document).on('change', "input[name='modal_cad_contato_input_Email']", (evento)=>{
        var statusModal = $("#modal_cad_contato").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var Email = $(evento.currentTarget);
				var regEmail = /^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?.]+@[a-z0-9]+\.[a-z]+(\.[a-z]+)?$/i;

            // Valida o Campo
                if(Email.val() != "" && Email.val() != " " && Email.val() != null && Email.val() != undefined && regEmail.test(Email.val())){
                    Email.addClass("is-valid");
                    Email.removeClass("is-invalid");
                } else {
                    Email.addClass("is-invalid");
                    Email.removeClass("is-valid");
                }
        }

    });

    // Valida o campo modal_cad_contato_input_Assunto

    $(document).on('change', "input[name='modal_cad_contato_input_Assunto']", (evento)=>{
        var statusModal = $("#modal_cad_contato").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var Assunto = $(evento.currentTarget);

            // Valida o Campo
                if(Assunto.val() != "" && Assunto.val() != " " && Assunto.val() != null && Assunto.val() != undefined){
                    Assunto.addClass("is-valid");
                    Assunto.removeClass("is-invalid");
                } else {
                    Assunto.addClass("is-invalid");
                    Assunto.removeClass("is-valid");
                }
        }

    });

    // Valida o campo modal_cad_contato_input_Mensagem

    $(document).on('change', "textarea[name='modal_cad_contato_input_Mensagem']", (evento)=>{
        var statusModal = $("#modal_cad_contato").iziModal("getState");

        if(statusModal == "opened"){
            // Declara as Variaveis
                var Mensagem = $(evento.currentTarget);

            // Valida o Campo
                if(Mensagem.val() != "" && Mensagem.val() != " " && Mensagem.val() != null && Mensagem.val() != undefined){
                    Mensagem.addClass("is-valid");
                    Mensagem.removeClass("is-invalid");
                } else {
                    Mensagem.addClass("is-invalid");
                    Mensagem.removeClass("is-valid");
                }
        }

    });

    // Realiza todo o procedimento de envio do contato

    $(document).on('click', "#btn-modal-enviar-contato", (evento)=>{

        // Declara as Variaveis

            var cache_leading = JSON.parse(localStorage.getItem("SOSHospedagens-Leading"));
            var Nome = $("input[name='modal_cad_contato_input_Nome']");
            var Email = $("input[name='modal_cad_contato_input_Email']");
            var regEmail = /^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?.]+@[a-z0-9]+\.[a-z]+(\.[a-z]+)?$/i; 
            var Telefone = $("input[name='modal_cad_contato_input_Telefone']");
            var Assunto = $("input[name='modal_cad_contato_input_Assunto']");
            var Mensagem = $("textarea[name='modal_cad_contato_input_Mensagem']");
            var botao = $(evento.currentTarget);

        // Remove todas as Classes

            Nome.removeClass("is-valid").removeClass("is-invalid");
            Email.removeClass("is-valid").removeClass("is-invalid");
            Telefone.removeClass("is-valid").removeClass("is-invalid");
            Assunto.removeClass("is-valid").removeClass("is-invalid");
            Mensagem.removeClass("is-valid").removeClass("is-invalid");

        // Valida os Campos do Formulário

            var validacao = []
                validacao[0] = Nome.val() != "" && Nome.val() != " " && Nome.val() != null && Nome.val() != undefined;
                validacao[1] = Telefone.val() != "" && Telefone.val() != " " && Telefone.val() != null && Telefone.val() != undefined;
                validacao[2] = Email.val() != "" && Email.val() != " " && Email.val() != null && Email.val() != undefined && regEmail.test(Email.val());
                validacao[3] = Assunto.val() != "" && Assunto.val() != " " && Assunto.val() != null && Assunto.val() != undefined;
                validacao[4] = Mensagem.val() != "" && Mensagem.val() != " " && Mensagem.val() != null && Mensagem.val() != undefined;

            var checaValidacao = validacao[0] && validacao[1] && validacao[2] && validacao[3] && validacao[4];

        // Verifica se a Validação esta correta e caso sim prossegue com a atualização do Leading

            if(checaValidacao){

                // Adiciona o estilo de campo correto

                    Nome.addClass("is-valid");
                    Email.addClass("is-valid");
                    Telefone.addClass("is-valid");
                    Assunto.addClass("is-valid");
                    Mensagem.addClass("is-valid");

                // Seta e grava os dados do Cache

                    cache_leading.nome = Nome.val();
                    cache_leading.email = Email.val();
                    cache_leading.telefone = Telefone.val();

                    localStorage.setItem("SOSHospedagens-Leading", JSON.stringify(cache_leading));

                // Executa o Ajax
                    
                    $.ajax({
                        type: "POST",
                        dataType: "html",
                        headers: {
                            Authorization : "Sessao.AppToken"
                        },
                        data: {
                            Funcao : 2,
                            'IP' : cache_leading.ip,
                            'Codigo': cache_leading.codigo,
                            'CpfCnpj': cache_leading.cpf_cnpj,
                            'Nome': cache_leading.nome,
                            'Email': cache_leading.email,
                            'Telefone': cache_leading.telefone,
                            'Cep': cache_leading.cep,
                            'Bairro': cache_leading.bairro,
                            'Cidade': cache_leading.cidade,
                            'UF': cache_leading.uf,
                            'Logradouro': cache_leading.logradouro,
                            'Numero': cache_leading.numero,
                            'NavegouSite': cache_leading.navegou_site ? 1 : 0,
                            'NavegouContato': cache_leading.navegou_contato ? 1 : 0,
                            'NavegouHospedagem': cache_leading.navegou_hospedagem ? 1 : 0
                        },
                        url: 'api/leadings.asp',
                        beforeSend: function(data){
                            swal({
                                title: 'Enviando os Seus Dados',
                                text: 'Aguarde',
                                onOpen: () => {
                                    swal.showLoading()
                                },
                                allowOutsideClick: false
                            })
                        },
                        error: function(erro) {
                            var mensagem = null; 
                            if (erro == "timeout") {				        						
                                mensagem = 'O Servidor demorou na resposta, tente novamente mais tarde!';
                            }
                            else {				        						
                                mensagem = 'Algo estranho aconteceu, tente novamente mais tarde!';
                            }
                            swal.close();
                            swal({
                                title: "Ops!",
                                text: mensagem,
                                type: "error",
                                allowOutsideClick: false
                            })
                        },		
                        success: function(retorno) {

                            // Gera a Cobrança
                    
                                $.ajax({
                                    type: "POST",
                                    dataType: "html",
                                    headers: {
                                        Authorization : "Sessao.AppToken"
                                    },
                                    data: {
                                        Funcao : 1,
                                        'CodLeading': cache_leading.codigo,
                                        'Nome': cache_leading.nome,
                                        'Email': cache_leading.email,
                                        'Telefone': cache_leading.telefone,
                                        'Assunto': Assunto.val(),
                                        'Mensagem': Mensagem.val()
                                    },
                                    url: 'api/contato.asp',
                                    beforeSend: function(data){
                                        swal({
                                            title: 'Finalizando o envio do Contato',
                                            text: 'Aguarde',
                                            onOpen: () => {
                                                swal.showLoading()
                                            },
                                            allowOutsideClick: false
                                        })
                                    },
                                    error: function(erro) {
                                        var mensagem = null; 
                                        if (erro == "timeout") {				        						
                                            mensagem = 'O Servidor demorou na resposta, tente novamente mais tarde!';
                                        }
                                        else {				        						
                                            mensagem = 'Algo estranho aconteceu, tente novamente mais tarde!';
                                        }
                                        swal.close();
                                        swal({
                                            title: "Ops!",
                                            text: mensagem,
                                            type: "error",
                                            allowOutsideClick: false
                                        })
                                    },		
                                    success: function(retorno) {

                                        // Fecha o sweetalert aberto

                                            swal.close();

                                        // Trata o retorno transformando em array

                                            var retorno = jQuery.parseJSON(retorno);

                                        // Envia mensagem de sucesso

                                            swal({
                                                title: retorno.Mensagem.Titulo,
                                                text: retorno.Mensagem.Texto,
                                                type: retorno.Mensagem.Tipo,
                                                allowOutsideClick: false
                                            }).then((data)=>{
                                                fecharModal("#modal_cad_contato");
                                            })

                                    }
                                });

                        }
                    });

            } else {
                
                // Verifica qual ou quais campos estão com erro

                    if(!validacao[0]){
                        Nome.addClass("is-invalid");
                    }

                    if(!validacao[1]){
                        Email.addClass("is-invalid");
                    }

                    if(!validacao[2]){
                        Telefone.addClass("is-invalid");
                    }

                    if(!validacao[3]){
                        Assunto.addClass("is-invalid");
                    }

                    if(!validacao[4]){
                        Mensagem.addClass("is-invalid");
                    }

            }

    })
