<%

	'+----------------------------------------------------------+'
	'|-Projeto: Tutti									        |'
	'|-Versão: 1.0										        |'
	'+----------------------------------------------------------+'
	'|-Helper: Helper Funções API						        |'
	'|-Descrição: Contém Funções Relacionadas a API             |'
	'+----------------------------------------------------------+'

		'Função para Debugar uma linha ou dados'

			Function retornaAPI(MensagemTitulo, MensagemTexto, MensagemTipo, StatusRequisicao, PossuiRetorno, DadosRetorno)

                retornoJSON = "{"
                retornoJSON = retornoJSON & """Mensagem"": {"
                retornoJSON = retornoJSON & """Titulo"": """ & MensagemTitulo & ""","
                retornoJSON = retornoJSON & """Texto"": """ & MensagemTexto & ""","
                retornoJSON = retornoJSON & """Tipo"": """ & MensagemTipo & """"
                retornoJSON = retornoJSON & "},"
                retornoJSON = retornoJSON & """Requisicao"": {"
                if PossuiRetorno = true then
                    retornoJSON = retornoJSON & """Retorno"": " & DadosRetorno & ","
                end if
                retornoJSON = retornoJSON & """Status"": " & StatusRequisicao & ","
                retornoJSON = retornoJSON & """Link_Referencia"": """ & CVG_URL & """"
                retornoJSON = retornoJSON & "}"
                retornoJSON = retornoJSON & "}"

                Response.ContentType = "application/json; charset=UTF-8"
                Response.Status = StatusRequisicao
                Response.Write retornoJSON
                Response.End

			End function

%>