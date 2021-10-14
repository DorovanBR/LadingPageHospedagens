// Função Responsavel pelo cache

    function GeraCache(){
        return new Promise((resolve, reject)=>{
            var leading = {
                codigo: null,
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

            renderizaModal("#modal_cad_ordem_servico", "<span class='text-muted'><i class='fa fa-plus'></i> Cadastrar Novo Voz</span>", {width: 600});

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
        var cache_leading = JSON.parse(localStorage.getItem("SOSHospedagens-Leading"));
        cache_leading.navegou_hospedagem = true;
        localStorage.setItem("SOSHospedagens-Leading", JSON.stringify(cache_leading));

        var botao = $(evento.currentTarget);

        $("input[name='input-servico']").val(botao.attr("data-servico"));

        abriraModal("#modal_cad_ordem_servico");
    });

    // Atualiza os Campos de Acordo com o Cep Preenchido

    $(document).on('change', "input[name='modal_cad_servico_input_CEP']", ()=>{

        // Verifica o Status da Modal

            var statusModal = $("#modal_cad_ordem_servico").iziModal("getState");

            if(statusModal == "opened"){

                // Declaração das Variaveis

                    var CEP = $("input[name='modal_cad_servico_input_CEP']");

                // Realiza a Validação

                    if(CEP.val() != undefined && CEP.val() != null && CEP.val() != "" && CEP.val() != " "){

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
                        toastr.error('O CEP precisa ser preenchido', 'Ops!');
                    }

            }

    })