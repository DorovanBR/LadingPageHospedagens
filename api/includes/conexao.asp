<%
	'Adiciona o Header

        Response.AddHeader "Access-Control-Allow-Origin", "*"
        Response.CharSet = "UTF-8"
        Response.CodePage = 65001
        Response.LCID = 1046

	'Verifica se recebeu o token da API'

		AppToken = Request.ServerVariables("HTTP_Authorization")

		if AppToken = "" or AppToken = "null" then

			'Escreve Mensagem de Erro'

				MensagemTitulo = "Ops!"
				MensagemTexto = "Token não informado na requisição"
				MensagemTipo = "error"

			'Retorna o JSON'

				formatoJSON = "{"
				formatoJSON = formatoJSON & """MensagemTitulo"": """ & MensagemTitulo & ""","
				formatoJSON = formatoJSON & """MensagemTexto"": """ & MensagemTexto & ""","
				formatoJSON = formatoJSON & """MensagemTipo"": """ & MensagemTipo & ""","
				formatoJSON = formatoJSON & """Status"": """ & 401 & """"
				formatoJSON = formatoJSON & "}"
				
			'Define o tipo de retorno e traz os dados em tela

                    Response.ContentType = "application/json"
                    Response.Write formatoJSON
                    Response.End

		end if

	'Criando Objeto ADODB.Connection'
	
		set ConexaoBD = Server.CreateObject("ADODB.Connection")
		
	'With para o Objeto ConexaoBD'
				
		with ConexaoBD
		
			'Conexão Localhost'
		
				.open(adodbDriver&";"&adodbServer&";"&adodbPort&";"&adodbDatabase&";"&adodbUser&";"&adodbPass&";"&adodbCharset&";"&adodbOption)
			
		End with
			
%>