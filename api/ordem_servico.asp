<!--#include file="includes/constantes.asp"-->
<!--#include file="includes/conexao.asp"-->
<!--#include file="helpers/helper_Charset.asp"-->
<!--#include file="helpers/helper_Base64.asp"-->
<!--#include file="helpers/helper_JSON.asp"-->
<!--#include file="helpers/helper_Debugger.asp"-->
<!--#include file="helpers/helper_ByteToString.asp"-->
<!--#include file="helpers/helper_FuncoesURL.asp"-->
<!--#include file="helpers/helper_FuncoesAPI.asp"-->
<%

	'+------------------------------------------------------------------------------+'
	'|-Projeto: SOS Hospedagens     				        	                    |'
	'|-Versão: 1.0									        	                    |'
	'+------------------------------------------------------------------------------+'
	'|-API: Ordens de Serviço da Landinpage       			        	            |'
	'+------------------------------------------------------------------------------+'
	'|-Metodos da API:  							        	                    |'
	'|- (1) - Cadastro de Ordens de Serviço  				        	            |'
	'|- (2) - Alteração de Ordens de Serviço 				        	            |'
	'|- (3) - Exclusão de Ordens de Serviço  				        	            |'
	'|- (4) - Consulta de Ordens de Serviço  				        	            |'
	'+------------------------------------------------------------------------------+'
	'|-Funções da API:								        	                    |'
	'+------------------------------------------------------------------------------+'

	'Declaração das Variaveis'

		Funcao = cInt(Request("Funcao"))

	'Metodos da API'

		Select Case cInt(Funcao)

            Case 1

                'Declara as Variaveis

                    CodLeading = Request("CodLeading")
                    CodServico = Request("CodServico")
                    FormaPagamento = EncodeUTF8(Request("FormaPagamento"))
                    ValorTotal = Request("ValorTotal")
                    Vencimento = Request("Vencimento")
                    Status = EncodeUTF8(Request("Status"))
                    LinkPagamento = Request("LinkPagamento")
                    
                    colunas_sql = ""
                    campos_sql = ""

                'Estrutura as colunas e valores do SQL

                    if trim(CodLeading) <> "" then
                        colunas_sql = colunas_sql & "cod_leading, "
                        campos_sql = campos_sql & "" & CodLeading & ", "
                    else

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Codigo do Leading do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                    if trim(CodServico) <> "" then
                        colunas_sql = colunas_sql & "cod_servico, "
                        campos_sql = campos_sql & "" & CodServico & ", "
                    else

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Codigo do Serviço do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                    if trim(FormaPagamento) <> "" then
                        colunas_sql = colunas_sql & "forma_pagamento, "
                        campos_sql = campos_sql & "'" & FormaPagamento & "', "
                    else

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "A Forma de Pagamento do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                    if trim(ValorTotal) <> "" then
                        colunas_sql = colunas_sql & "valor_total, "
                        campos_sql = campos_sql & "" & ValorTotal & ", "
                    else

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Valor Total do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                    if trim(Vencimento) <> "" then
                        colunas_sql = colunas_sql & "vencimento, "
                        campos_sql = campos_sql & "'" & Vencimento & "', "
                    else

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Vencimento do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                    if trim(Status) <> "" then
                        colunas_sql = colunas_sql & "status, "
                        campos_sql = campos_sql & "'" & Status & "', "
                    else

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Status do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                    if trim(LinkPagamento) <> "" then
                        colunas_sql = colunas_sql & "link_pagamento, "
                        campos_sql = campos_sql & "'" & LinkPagamento & "', "
                    end if

                'Insere os Campos de Controle

                    DataCadastro = Year(Now()) & "-" & Month(Now()) & "-" & Day(Now())
                    colunas_sql = colunas_sql & "data_cadastro, "
                    campos_sql = campos_sql & "'" & DataCadastro & "', "

                    HorarioCadastro = Hour(Now()) & ":" & Minute(Now()) & ":" & Second(Now())
                    colunas_sql = colunas_sql & "horario_cadastro, "
                    campos_sql = campos_sql & "'" & HorarioCadastro & "', "

                    CodSituacao = 1
                    colunas_sql = colunas_sql & "cod_situacao"
                    campos_sql = campos_sql & "" & CodSituacao & ""

                    ' call debuga(colunas_sql, false)
                    ' call debuga(campos_sql, true)

                'Estrutura a String SQL

                    string_sql = "insert into ordens_servico ("&colunas_sql&") VALUES ("&campos_sql&")"

                    ' call debuga(string_sql, true)

                'Realiza a Inserção

                    set insereOrdemServico = ConexaoBD.Execute(string_sql)

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Ordem de Serviço Cadastrada com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200
                    
                'Define o tipo de retorno e traz os dados em tela

                    call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

            Case 2

                'Declara as Variaveis

                    Codigo = Request("Codigo")
                    CodLeading = Request("CodLeading")
                    CodServico = Request("CodServico")
                    FormaPagamento = EncodeUTF8(Request("FormaPagamento"))
                    ValorTotal = Request("ValorTotal")
                    Vencimento = Request("Vencimento")
                    Status = EncodeUTF8(Request("Status"))
                    LinkPagamento = Request("LinkPagamento")

                    campos_sql = ""

                'Verifica se o Codigo foi inserido                    

                    if cInt(Codigo) = 0 or Codigo = "" then
                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Codigo do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                'Estrutura as colunas e valores do SQL

                    if trim(CodLeading) <> "" then
                        campos_sql = campos_sql & "cod_leading = " & CodLeading & ", "
                    end if

                    if trim(CodServico) <> "" then
                        campos_sql = campos_sql & "cod_servico = " & CodServico & ", "
                    end if

                    if trim(FormaPagamento) <> "" then
                        campos_sql = campos_sql & "forma_pagamento = '" & FormaPagamento & "', "
                    end if

                    if trim(ValorTotal) <> "" then
                        campos_sql = campos_sql & "valor_total = " & ValorTotal & ", "
                    end if

                    if trim(Vencimento) <> "" then
                        campos_sql = campos_sql & "vencimento = '" & Vencimento & "', "
                    end if

                    if trim(Status) <> "" then
                        campos_sql = campos_sql & "status = '" & Status & "', "
                    end if

                    if trim(LinkPagamento) <> "" then
                        campos_sql = campos_sql & "link_pagamento = '" & LinkPagamento & "', "
                    end if

                'Insere os Campos de Controle

                    DataAtualizacao = Year(Now()) & "-" & Month(Now()) & "-" & Day(Now())
                    campos_sql = campos_sql & "data_atualizacao = '" & DataAtualizacao & "', "

                    HorarioAtualizacao = Hour(Now()) & ":" & Minute(Now()) & ":" & Second(Now())
                    campos_sql = campos_sql & "horario_atualizacao = '" & HorarioAtualizacao & "'"

                    ' call debuga(colunas_sql, false)
                    ' call debuga(campos_sql, true)

                'Estrutura a String SQL

                    string_sql = "update ordens_servico set " & campos_sql & " where codigo = " & Codigo

                    ' call debuga(string_sql, true)

                'Realiza a Alteração

                    set alteraOrdemServico = ConexaoBD.Execute(string_sql)

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Ordem de Serviço Atualizada com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200
                    
                'Define o tipo de retorno e traz os dados em tela

                    call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

            Case 3

                'Declara as Variaveis

                    Codigo = Request("Codigo")

                    campos_sql = ""

                'Verifica se o Codigo foi inserido                    

                    if cInt(Codigo) = 0 or Codigo = "" then

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Ops"
                            MensagemTexto = "O Codigo do registro não foi enviado ou esta incorreto, tente novamente mais tarde"
                            MensagemTipo = "error"
                            StatusRequisicao = 406
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

                'Verifica se o Registro já foi excluido

                    string_sql = "select count(codigo) as Total from ordens_servico where cod_situacao = 2 and codigo = " & Codigo

                    set checaRegistro = ConexaoBD.Execute(string_sql)

                    if cInt(checaRegistro("Total")) >= 1 then

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Eita"
                            MensagemTexto = "Esse registro já foi excluido, verifique e tente novamente"
                            MensagemTipo = "warning"
                            StatusRequisicao = 400
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)


                    else

                        'Insere os Campos de Controle

                            DataAtualizacao = Year(Now()) & "-" & Month(Now()) & "-" & Day(Now())
                            campos_sql = campos_sql & "data_atualizacao = '" & DataAtualizacao & "', "

                            HorarioAtualizacao = Hour(Now()) & ":" & Minute(Now()) & ":" & Second(Now())
                            campos_sql = campos_sql & "horario_atualizacao = '" & HorarioAtualizacao & "', "

                            CodSituacao = 2
                            campos_sql = campos_sql & "cod_situacao = " & CodSituacao & ""

                        'Estrutura a String SQL

                            string_sql = "update ordens_servico set " & campos_sql & " where codigo = " & Codigo

                            ' call debuga(string_sql, true)

                        'Realiza a Exclusão

                            set excluiOrdemServico = ConexaoBD.Execute(string_sql)

                        'Estrutura o JSON de retorno

                            MensagemTitulo = "Sucesso"
                            MensagemTexto = "Serviço Excluído com sucesso."
                            MensagemTipo = "success"
                            StatusRequisicao = 200
                            
                        'Define o tipo de retorno e traz os dados em tela

                            call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, false, DadosRetorno)

                    end if

            Case 4

                'Declara as Variaveis

                    Codigo = Request("Codigo")

                'Verifica se o Codigo foi inserido                    

                    if cInt(Codigo) = 0 or Codigo = "" then
                        string_sql = "select * from ordens_servico where cod_situacao = 1"
                    else
                        string_sql = "select * from ordens_servico where cod_situacao = 1 and codigo = " & Codigo
                    end if

                'Verifica se o Registro já foi excluido

                    set consultaOrdemServico = ConexaoBD.Execute(string_sql)

                'Cria a Estrutura dos Registros

                    EstruturaOrdemServico = ""

                'Faz um laço de repetição para listar os dados na tela

                    while not consultaOrdemServico.eof

                        CodLeading = consultaOrdemServico("cod_leading")
                        CodServico = consultaOrdemServico("cod_servico")
                        FormaPagamento = consultaOrdemServico("forma_pagamento")
                        ValorTotal = consultaOrdemServico("valor_total")
                        Vencimento = consultaOrdemServico("vencimento")
                        Status = consultaOrdemServico("status")
                        LinkPagamento = consultaOrdemServico("link_pagamento")
                        DataCadastro = consultaOrdemServico("data_cadastro")
                        HorarioCadastro = consultaOrdemServico("horario_cadastro")
                        DataAtualizacao = consultaOrdemServico("data_atualizacao")
                        HorarioAtualizacao = consultaOrdemServico("horario_atualizacao")

                        EstruturaOrdemServico = EstruturaOrdemServico & "{"
                        EstruturaOrdemServico = EstruturaOrdemServico & """CodLeading"": """ & CodLeading & ""","
                        EstruturaOrdemServico = EstruturaOrdemServico & """CodServico"": """ & CodServico & ""","
                        EstruturaOrdemServico = EstruturaOrdemServico & """FormaPagamento"": """ & DecodeUTF8(FormaPagamento) & ""","
                        EstruturaOrdemServico = EstruturaOrdemServico & """ValorTotal"": """ & ValorTotal & ""","
                        EstruturaOrdemServico = EstruturaOrdemServico & """Vencimento"": """ & Vencimento & ""","
                        EstruturaOrdemServico = EstruturaOrdemServico & """Status"": """ & DecodeUTF8(Status) & ""","
                        EstruturaOrdemServico = EstruturaOrdemServico & """LinkPagamento"": """ & LinkPagamento & ""","
                        EstruturaOrdemServico = EstruturaOrdemServico & """DataCadastro"": """ & DataCadastro & ""","
                        EstruturaOrdemServico = EstruturaOrdemServico & """HorarioCadastro"": """ & HorarioCadastro & ""","
                        EstruturaOrdemServico = EstruturaOrdemServico & """DataAtualizacao"": """ & DataAtualizacao & ""","
                        EstruturaOrdemServico = EstruturaOrdemServico & """HorarioAtualizacao"": """ & HorarioAtualizacao & """"
                        EstruturaOrdemServico = EstruturaOrdemServico & "}"

                        consultaOrdemServico.movenext
                    wend

                'Ajusta a Estrutura dos Registros JSON

                    EstruturaOrdemServico = replace(EstruturaOrdemServico, "}{", "},{")

                'Estrutura o JSON de retorno

                    MensagemTitulo = "Sucesso"
                    MensagemTexto = "Ordens de Serviço carregados com sucesso."
                    MensagemTipo = "success"
                    StatusRequisicao = 200

                    DadosRetorno = "{"
                    DadosRetorno = DadosRetorno & """OrdemServico"": [" & EstruturaOrdemServico & "]"
                    DadosRetorno = DadosRetorno & "}"
                    
                'Define o tipo de retorno e traz os dados em tela

                    call retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, True, DadosRetorno)

        End Select

%>