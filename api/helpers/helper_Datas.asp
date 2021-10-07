<%

	'+--------------------------------------------------+'
	'|-Projeto: API Autoweb Novo						|'
	'|-Versão: 1.0										|'
	'+--------------------------------------------------+'
	'|-Helper: Helper Datas								|'
	'|-Descrição: Contém funções relacionadas a Datas	|'
	'+--------------------------------------------------+'

		'Função para Tratar a data em formato SQL'

			Function checa_data_expirada(data_origem, data_final)
                data_origem = CDate(data_origem)
                data_final = CDate(data_final)
                
                compara_datas = DateDiff("s", data_origem, data_final)
                
                if compara_datas <= 0 then
                    checa_data_expirada = true
                else
                    checa_data_expirada = false
                end if 
			End function

        'Função para Adicionar Segundos a uma data

            Function add_segundos_data(data_origem, segundos, formataSQL)
                data_origem = CDate(data_origem)
                data_final = DateAdd("s", segundos, data_origem)

                if formataSQL = true then
                    data_final = year(data_final) & "-" & month(data_final) & "-" & day(data_final) & " " & hour(data_final) & ":" & minute(data_final) & ":" & second(data_final)
                end if

                add_segundos_data = data_final
            End Function

        'Função data_tela
            
            Function data_tela(data)
                On Error Resume Next
                    if data <> "" then
                        data = Cdate(data)

                        dia = Day(data)

                        if dia < 10 then
                            dia = "0" & cstr(dia)
                        End if

                        mes = month(data)

                        if mes < 10 then
                            mes = "0" & cstr(mes)
                        End if

                        ano = year(data)

                        if ano < 1900 then
                            ano = ano + 1900
                        End if

                        data_tela = cstr(dia) & "/" & cstr(mes) & "/" & cstr(ano)
                    end if

                if Err.Number > 0 then
                    data_tela "00/00/0000"
                End if
            End Function

%>