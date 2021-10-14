<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/conexao.asp"-->
<!--#include file="helpers/helper_Charset.asp"-->
<!--#include file="helpers/helper_Base64.asp"-->
<!--#include file="helpers/helper_JSON.asp"-->
<!--#include file="helpers/helper_Debugger.asp"-->
<!--#include file="helpers/helper_Datas.asp"-->
<!--#include file="helpers/helper_ByteToString.asp"-->
<!--#include file="helpers/helper_FuncoesURL.asp"-->
<!--#include file="helpers/helper_FuncoesAPI.asp"-->
<%

	'+------------------------------------------------------------------------------+'
	'|-Projeto: SOS Hospedagens     				        	                    |'
	'|-Versão: 1.0									        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-API: Configurações do Landinpage 			        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-Metodos da API:								        	                    |'
	'|- (1) - Autorização da API                                                    |'
	'|- (2) - Gerar Cobrança                                                        |'
	'+------------------------------------------------------------------------------+'
	'|-Funções da API:								        	                    |'
    '|-(1) - SolicitaToken(): Gera/Carrega o Token de Acesso a Juno API             |'
	'+------------------------------------------------------------------------------+'

	'Declaração das Variaveis'

		Funcao = cInt(Request("Funcao"))
		Servidor = Request("Servidor")

        if Servidor = "PROD" then
            uri = "https://api.juno.com.br/"
        else
            uri = "https://sandbox.boletobancario.com/"
        end if

    'Funções da API

        Function SolicitaToken(Configuracao)

            'Consulta as Configurações

                set ConsultaConfiguracao = ConexaoBD.Execute("select juno_clientId, juno_clientSecret, juno_resourceToken from configuracoes where codigo = " & Configuracao)

            'Verifica se tem registros em aberto na Tabela de autenticação da juno

                set ConsultaAutenticacao = ConexaoBD.Execute("select count(codigo) as Total from juno_autenticacao where cod_situacao = 1")

                if cInt(ConsultaAutenticacao("Total")) > 0 then

                    'Define as Variaveis

                        DataAtual = year(now()) & "-" & month(now()) & "-" & day(now())
                        HorarioAtual = hour(now()) & ":" & minute(now()) & ":" & second(now())

                    'Consulta quantos registros estão ativos e válidos

                        set ConsultaAutenticacaoValida = ConexaoBD.Execute("select * from juno_autenticacao where cod_situacao = 1")

                    'Faz um laço de repetição para validar os registros da consulta

                        while not ConsultaAutenticacaoValida.EOF

                            DataHorarioAtual = year(now()) & "-" & month(now()) & "-" & day(now()) & " " & hour(now()) & ":" & minute(now()) & ":" & second(now())
                            DataHorarioExpiracao = ConsultaAutenticacaoValida("data_expiracao") & " " & split(ConsultaAutenticacaoValida("horario_expiracao"), " ")(1)
                            checaSessao = checa_data_expirada(CDate(DataHorarioAtual), CDate(DataHorarioExpiracao))

                            DataAtualizacao = year(now()) & "-" & month(now()) & "-" & day(now())
                            HorarioAtualizacao = hour(now()) & ":" & minute(now()) & ":" & second(now())

                            if checaSessao = true then

                                'Atualiza o Token Atual para Inativo

                                    set AtualizaAutenticacao = ConexaoBD.Execute("update juno_autenticacao set data_atualizacao = '"&DataAtualizacao&"', horario_atualizacao = '"&HorarioAtualizacao&"', cod_situacao = 2 where codigo = " & ConsultaAutenticacaoValida("Codigo"))
                                
                                'Seta o Metodo

                                    metodo = "authorization-server/oauth/token"

                                'Declara as variaveis
                                    
                                    clientId = ConsultaConfiguracao("juno_clientId")
                                    clientSecret = ConsultaConfiguracao("juno_clientSecret")
                                    Authorization = Base64Encode(clientId & ":" & clientSecret)

                                'Criando o objeto de conexão e retorno'
                                
                                    set xhr = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
                                    set JSON = New JSONobject

                                'Cria o payload

                                    payload = "grant_type=client_credentials"

                                'Definindo a url de conexão'

                                    xhr.open "POST", uri & metodo, false

                                'Definindo o cabeçalho'

                                    xhr.setRequestHeader "Authorization", "Basic " & Authorization
                                    xhr.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"

                                'Enviando as informações'
                                
                                    xhr.send payload

                                'Transforma o retorno em JSON

                                    set retorno = JSON.parse(xhr.ResponseText)

                                    DataCadastro = year(now()) & "-" & month(now()) & "-" & day(now())
                                    HorarioCadastro = hour(now()) & ":" & minute(now()) & ":" & second(now())
                                    DataHorarioExpiracao = add_segundos_data(CDate(DataCadastro & " " & HorarioCadastro) ,retorno("expires_in"), true)
                                    DataExpiracao = split(DataHorarioExpiracao, " ")(0)
                                    HorarioExpiracao = split(DataHorarioExpiracao, " ")(1)
                                    DataHorarioAtual = year(now()) & "-" & month(now()) & "-" & day(now()) & " " & hour(now()) & ":" & minute(now()) & ":" & second(now())
                                    CodSituacao = 1

                                'Insere o registro no banco

                                    set insereRegistro = ConexaoBD.Execute("insert into juno_autenticacao (access_token, token_type, expires_in, scope, user_name, jti, data_expiracao, horario_expiracao, data_cadastro, horario_cadastro, cod_situacao) VALUES ('"&retorno("access_token")&"', '"&retorno("token_type")&"', "&retorno("expires_in")&", '"&retorno("scope")&"', '"&retorno("user_name")&"', '"&retorno("jti")&"', '"&DataExpiracao&"', '"&HorarioExpiracao&"',  '"&DataCadastro&"',  '"&HorarioCadastro&"', "&CodSituacao&")")
                        
                                'Estrutura o JSON de retorno

                                    DadosSessao = "{"
                                    DadosSessao = DadosSessao & """Token"": """ & retorno("access_token") & ""","
                                    DadosSessao = DadosSessao & """DataAtual"": """ & CDate(DataHorarioAtual) & ""","
                                    DadosSessao = DadosSessao & """DataExpiracao"": """ & CDate(DataHorarioExpiracao) & ""","
                                    DadosSessao = DadosSessao & """ResourceToken"": """ & ConsultaConfiguracao("juno_resourceToken") & """"
                                    DadosSessao = DadosSessao & "}"

                                    SolicitaToken = DadosSessao
                                    Exit Function
                            else
                            
                                'Estrutura o JSON de retorno
                                
                                    DadosSessao = "{"
                                    DadosSessao = DadosSessao & """Token"": """ & ConsultaAutenticacaoValida("access_token") & ""","
                                    DadosSessao = DadosSessao & """DataAtual"": """ & CDate(DataHorarioAtual) & ""","
                                    DadosSessao = DadosSessao & """DataExpiracao"": """ & CDate(DataHorarioExpiracao) & ""","
                                    DadosSessao = DadosSessao & """ResourceToken"": """ & ConsultaConfiguracao("juno_resourceToken") & """"
                                    DadosSessao = DadosSessao & "}"
                                    
                                    SolicitaToken = DadosSessao
                                    Exit Function
                            end if

                            ConsultaAutenticacaoValida.movenext
                        wend
                else

                    'Seta o Metodo

                        metodo = "authorization-server/oauth/token"

                    'Declara as variaveis
                        
                        clientId = ConsultaConfiguracao("juno_clientId")
                        clientSecret = ConsultaConfiguracao("juno_clientSecret")
                        Authorization = Base64Encode(clientId & ":" & clientSecret)

                    'Criando o objeto de conexão e retorno'
                    
                        set xhr = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
                        set JSON = New JSONobject

                    'Cria o payload

                        payload = "grant_type=client_credentials"

                    'Definindo a url de conexão'

                        xhr.open "POST", uri & metodo, false

                    'Definindo o cabeçalho'

                        xhr.setRequestHeader "Authorization", "Basic " & Authorization
                        xhr.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"

                    'Enviando as informações'
                    
                        xhr.send payload

                    'Transforma o retorno em JSON

                        set retorno = JSON.parse(xhr.ResponseText)

                        DataCadastro = year(now()) & "-" & month(now()) & "-" & day(now())
                        HorarioCadastro = hour(now()) & ":" & minute(now()) & ":" & second(now())
                        DataHorarioExpiracao = add_segundos_data(CDate(DataCadastro & " " & HorarioCadastro) ,retorno("expires_in"), true)
                        DataExpiracao = split(DataHorarioExpiracao, " ")(0)
                        HorarioExpiracao = split(DataHorarioExpiracao, " ")(1)
                        DataHorarioAtual = year(now()) & "-" & month(now()) & "-" & day(now()) & " " & hour(now()) & ":" & minute(now()) & ":" & second(now())
                        CodSituacao = 1

                    'Insere o registro no banco

                        set insereRegistro = ConexaoBD.Execute("insert into juno_autenticacao (access_token, token_type, expires_in, scope, user_name, jti, data_expiracao, horario_expiracao, data_cadastro, horario_cadastro, cod_situacao) VALUES ('"&retorno("access_token")&"', '"&retorno("token_type")&"', "&retorno("expires_in")&", '"&retorno("scope")&"', '"&retorno("user_name")&"', '"&retorno("jti")&"', '"&DataExpiracao&"', '"&HorarioExpiracao&"',  '"&DataCadastro&"',  '"&HorarioCadastro&"', "&CodSituacao&")")
            
                    'Estrutura o JSON de retorno

                        DadosSessao = "{"
                        DadosSessao = DadosSessao & """Token"": """ & retorno("access_token") & ""","
                        DadosSessao = DadosSessao & """DataAtual"": """ & CDate(DataHorarioAtual) & ""","
                        DadosSessao = DadosSessao & """DataExpiracao"": """ & CDate(DataHorarioExpiracao) & ""","
                        DadosSessao = DadosSessao & """ResourceToken"": """ & ConsultaConfiguracao("juno_resourceToken") & """"
                        DadosSessao = DadosSessao & "}"

                        SolicitaToken = DadosSessao

                end if

        End Function

	'Metodos da API'

		Select Case cInt(Funcao)

            Case 1

                'Declara as Variaveis

                    Configuracao = Request("Configuracao")

                'Gera o Token

                    DadosRetorno = SolicitaToken(Configuracao)
                
                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Token Carregado com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200
                    
                'Define o tipo de retorno e traz os dados em tela

                    call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, True, DadosRetorno)
                
            Case 2

                'Declara o Metodo de JSON
                
                    set JSON = New JSONobject

                'Declara as Variaveis

                    Configuracao = Request("Configuracao")
                    set DadosSessao = JSON.parse(SolicitaToken(Configuracao))

                    Leading = Request("Leading")
                    Servico = Request("Servico")

                'Consulta os Dados do Serviço

                    set ConsultaServico = ConexaoBD.Execute("select * from servicos where codigo = " & Servico)

                'Consulta os Dados do Leading

                    set ConsultaLeading = ConexaoBD.Execute("select * from leadings where codigo = " & Leading)

                    Descricao = ConsultaServico("nome")
                    Referencia = """" & ConsultaServico("nome") & """"
                    ValorTotal = replace(replace(ConsultaServico("valor"), ".", ""), ",", ".")
                    DataVencimento = Request("DataVencimento")
                    TiposPagamento = Request("TiposPagamento")
                    
                    Nome = ConsultaLeading("nome")
                    Documento = replace(replace(ConsultaLeading("cpf_cnpj"), ".", ""), "-", "")
                    Email = ConsultaLeading("email")
                    Contato = replace(replace(replace(replace(ConsultaLeading("telefone"), " ", ""), "-", ""), "(", ""), ")", "")

                    EnderecoRua = ConsultaLeading("logradouro")
                    EnderecoNumero = ConsultaLeading("numero")
                    EnderecoBairro = ConsultaLeading("bairro")
                    EnderecoCidade = ConsultaLeading("cidade")
                    EnderecoEstado = ConsultaLeading("uf")
                    EnderecoCEP = replace(ConsultaLeading("cep"), "-", "")

                'Seta o Metodo

                    metodo = "api-integration/charges"

                'Criando o objeto de conexão e retorno'
                
                    set xhr = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")

                'Cria o payload

                    payload = "{"

                    payload = payload & """charge"": {"
                    payload = payload & """description"": """ & Descricao & ""","
                    payload = payload & """references"": [" & Referencia & "],"
                    payload = payload & """amount"": " & ValorTotal & ","
                    payload = payload & """dueDate"": """ & DataVencimento & ""","
                    payload = payload & """paymentTypes"": [" & TiposPagamento & "]"
                    payload = payload & "},"

                    payload = payload & """billing"": {"
                    payload = payload & """name"": """ & Nome & ""","
                    payload = payload & """document"": """ & Documento & ""","
                    payload = payload & """email"": """ & Email & ""","
                    payload = payload & """phone"": """ & Contato & ""","

                    payload = payload & """address"": {"
                    payload = payload & """street"": """ & EnderecoRua & ""","
                    payload = payload & """number"": """ & EnderecoNumero & ""","
                    payload = payload & """neighborhood"": """ & EnderecoBairro & ""","
                    payload = payload & """city"": """ & EnderecoCidade & ""","
                    payload = payload & """state"": """ & EnderecoEstado & ""","
                    payload = payload & """postCode"": """ & EnderecoCEP & """"
                    payload = payload & "}"

                    payload = payload & "}"

                    payload = payload & "}"

                    ' call debuga(payload, true)

                'Definindo a url de conexão'

                    xhr.open "POST", uri & metodo, false

                'Definindo o cabeçalho'

                    xhr.setRequestHeader "Authorization", "Bearer " & DadosSessao("Token")
                    xhr.setRequestHeader "X-Api-Version", "2"
                    xhr.setRequestHeader "X-Resource-Token", DadosSessao("ResourceToken")
                    xhr.setRequestHeader "Content-Type", "application/json;charset=UTF-8"
                    
                'Enviando as informações'
                
                    xhr.send payload

                'Transforma o retorno em JSON

                    set retorno = JSON.parse(xhr.ResponseText)

                'Declara as Variaveis de Controle

                    DataCadastro = year(now()) & "-" & month(now()) & "-" & day(now())
                    HorarioCadastro = hour(now()) & ":" & minute(now()) & ":" & second(now())
                    CodSituacao = 1

                'Inserir o Registro de Ordem de Serviço

                    set InsereOrdemServico = ConexaoBD.Execute("insert into ordens_servico (cod_leading, cod_servico, forma_pagamento, valor_total, vencimento, status, link_pagamento, data_cadastro, horario_cadastro, cod_situacao) VALUES ("&Leading&", "&Servico&", '"&TiposPagamento&"', "&ValorTotal&", '"&DataVencimento&"', '"&retorno("_embedded")("charges")(0)("status")&"', '"&retorno("_embedded")("charges")(0)("checkoutUrl")&"', '"&DataCadastro&"', '"&HorarioCadastro&"', "&CodSituacao&")")

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Cobrança Gerada com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200

                    DadosRetorno = "{"
                    DadosRetorno = DadosRetorno & """Servico"": """ & Descricao & ""","
                    DadosRetorno = DadosRetorno & """ValorTotal"": """ & ValorTotal & ""","
                    DadosRetorno = DadosRetorno & """DataVencimento"": """ & DataVencimento & ""","
                    DadosRetorno = DadosRetorno & """LinkPagamento"": """ & retorno("_embedded")("charges")(0)("checkoutUrl") & """"
                    DadosRetorno = DadosRetorno & "}"
                    
                'Define o tipo de retorno e traz os dados em tela

                    call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, True, DadosRetorno)

        End Select

%>