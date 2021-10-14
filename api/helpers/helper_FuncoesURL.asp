<%

	'+----------------------------------------------------------+'
	'|-Projeto: Tutti									        |'
	'|-Versão: 1.0										        |'
	'+----------------------------------------------------------+'
	'|-Helper: Helper Funções URL						        |'
	'|-Descrição: Contém Funções Relacionadas a URL             |'
	'+----------------------------------------------------------+'

        'Codifica a URL'

            Function UrlEncode(s)
                Dim JSEngine

                Set JSEngine = CreateObject("MSScriptControl.ScriptControl")
                    JSEngine.Language = "JScript"
                UrlEncode = JSEngine.CodeObject.encodeURIComponent(s)
                UrlEncode = Replace(UrlEncode, "'", "%27")
                UrlEncode = Replace(UrlEncode, """", "%22")
            End Function

		'Decodifica a URL'

            Function UrlDecode(s)
                Dim JSEngine

                Set JSEngine = CreateObject("MSScriptControl.ScriptControl")
                    JSEngine.Language = "JScript"
                UrlDecode = Replace(s, "+", " ")
                UrlDecode = JSEngine.CodeObject.decodeURIComponent(UrlDecode)
            End Function

%>