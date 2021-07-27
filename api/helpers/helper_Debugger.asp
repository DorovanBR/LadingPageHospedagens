<%

	'+--------------------------------------------------+'
	'|-Projeto: API Autoweb Novo						|'
	'|-Versão: 1.0										|'
	'+--------------------------------------------------+'
	'|-Helper: Helper Debugger							|'
	'|-Descrição: Contém funções relacionadas a Datas	|'
	'+--------------------------------------------------+'

		'Função para Debugar uma linha ou dados'

			Function debuga(dados, finaliza)
                response.write dados & "<br>"

                if finaliza = true then
                    response.end
                end if
			End function

%>