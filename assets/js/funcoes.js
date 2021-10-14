// Função para Mascara de Telefone

	var SPMaskBehavior = function (val) {
	  return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
	},
	spOptions = {
	  onKeyPress: function(val, e, field, options) {
	      field.mask(SPMaskBehavior.apply({}, arguments), options);
	    }
	};

	var SPMaskBehavior2 = function (val) {
		return val.replace(/\D/g, '').length === 11 ? '000.000.000-00' : '00.000.000/0000-09';
	  },
	  spOptions2 = {
		onKeyPress: function(val, e, field, options) {
			field.mask(SPMaskBehavior2.apply({}, arguments), options);
		  }
	  };

//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
	
//+--------------------------------------------------------------------------------+
//|                                                                                |
//|                jQuery Com Gerenciamento das Funções Padrões	    	           |
//|                                                                                |
//+--------------------------------------------------------------------------------+

//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------

	// Função para renderizar a modal
	
		function renderizaModal(modal_id, title, options){

			if(options == undefined){
				options = {}
			}

			$(modal_id).iziModal({
				title: title,
				subtitle: '',
				headerColor: options.hasOwnProperty("headerColor") ? options.headerColor : '#EEEEEE',
				background: options.hasOwnProperty("background") ? options.background : '#FFFFFF',
				theme: 'light',  // light
				appendTo: options.hasOwnProperty("appendTo") ? options.appendTo : '.body', // or false
				icon: null,
				iconText: null,
				iconColor: '',
				rtl: false,
				width: options.hasOwnProperty("width") ? options.width : 600,
				top: null,
				bottom: null,
				borderBottom: true,
				padding: 0,
				radius: 0,
				zindex: options.hasOwnProperty("zindex") ? options.zindex : 1050,
				iframe: false,
				iframeHeight: 400,
				iframeURL: null,
				focusInput: true,
				group: '',
				loop: false,
				navigateCaption: true,
				navigateArrows: true, // Boolean, 'closeToModal', 'closeScreenEdge'
				autoOpen: 0, // Boolean, Number
				bodyOverflow: false,
				fullscreen: false,
				openFullscreen: false,
				closeOnEscape: true,
				closeButton: true,
				overlay: true,
				overlayClose: false,
				overlayColor: 'rgba(0, 0, 0, 0.4)',
				timeout: false,
				timeoutProgressbar: false,
				pauseOnHover: true,
				timeoutProgressbarColor: 'rgba(255,255,255,0.5)',
				transitionIn: 'comingIn',
				transitionOut: 'comingOut',
				transitionInOverlay: 'fadeIn',
				transitionOutOverlay: 'fadeOut',
			    onFullscreen: options.hasOwnProperty("onFullscreen") ? options.onFullscreen : ()=>{},
			    onResize: options.hasOwnProperty("onResize") ? options.onResize : ()=>{},
			    onOpening: options.hasOwnProperty("onOpening") ? options.onOpening : ()=>{},
			    onOpened: options.hasOwnProperty("onOpened") ? options.onOpened : ()=>{},
			    onClosing: options.hasOwnProperty("onClosing") ? options.onClosing : ()=>{},
			    onClosed: options.hasOwnProperty("onClosed") ? options.onClosed : ()=>{},
			    afterRender: options.hasOwnProperty("afterRender") ? options.afterRender : ()=>{}
			});
		}

//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------

	// Função para pegar a URL

		function pegaUrl(){

			// Retorna a Url atual

				return window.location.href

		}

//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------

	// Função para abrir a modal
	
		function abriraModal(modal_id){
			$(modal_id).iziModal('open');
		}

//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------

	// Função para fechar a modal
	
		function fecharModal(modal_id){
			$(modal_id).iziModal('close');
		}

//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------

	// Função para limpar formulario
	
		function limpaFormulario(formulario_id){
			var formulario = $(formulario_id);
			for(ponteiroFormulario = 0; ponteiroFormulario < formulario.length; ponteiroFormulario++){
				for(ponteiroCampos = 0; ponteiroCampos < formulario[ponteiroFormulario].length; ponteiroCampos++){
					formulario[ponteiroFormulario][ponteiroCampos].value = null
				}
			}
		}

//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------

	// Função para gerenciar os logs

		function log(tipo, mensagem){
			switch(tipo){
				case "error":
					console.error(mensagem);
					break;
				case "warn":
					console.warn(mensagem);
					break;
				default:
					console.log(mensagem);
					break;
			}
		}

//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------

	// Função para Gerar Token

		function GeraToken(tamanho, tiposcaracteres = 1){

			// Valida as variaveis de entrada

				if(typeof tamanho != 'number' || !Number.isInteger(tamanho) || tamanho < 1){
					return console.error("function GeraToken(tamanho, tiposcaracteres): a variavel [tamanho] deve conter apenas numeros inteiros e acima de 0");
				}
				if(typeof tiposcaracteres != 'number' || !Number.isInteger(tiposcaracteres) || tiposcaracteres < 1 || tiposcaracteres > 7){
					return console.error("function GeraToken(tamanho, tiposcaracteres): a variavel [tiposcaracteres] deve conter apenas numeros inteiros e estar entre 1 á 7");
				}

			// Declara as Variaveis

				var Token = "";
				var TipoCaracter = null;
				var Caracter = null;

			// Realiza a repetição para gerar o token

				for(var ponteiro = 0;ponteiro < tamanho;ponteiro++){

					TipoCaracter = Math.floor((Math.random() * tiposcaracteres) + 1);

					switch(TipoCaracter){
						case 1:
							Caracter = String.fromCharCode(Math.floor(Math.random() * (tabelaASCII.LetrasMaiusculas.fim - tabelaASCII.LetrasMaiusculas.inicio + 1)) + tabelaASCII.LetrasMaiusculas.inicio);
							break;
						case 2:
							Caracter = String.fromCharCode(Math.floor(Math.random() * (tabelaASCII.LetrasMinusculas.fim - tabelaASCII.LetrasMinusculas.inicio + 1)) + tabelaASCII.LetrasMinusculas.inicio);
							break;
						case 3:
							Caracter = String.fromCharCode(Math.floor(Math.random() * (tabelaASCII.Numeros.fim - tabelaASCII.Numeros.inicio + 1)) + tabelaASCII.Numeros.inicio);
							break;
						case 4:
							Caracter = String.fromCharCode(Math.floor(Math.random() * (tabelaASCII.CaracteresEspeciais1.fim - tabelaASCII.CaracteresEspeciais1.inicio + 1)) + tabelaASCII.CaracteresEspeciais1.inicio);
							break;
						case 5:
							Caracter = String.fromCharCode(Math.floor(Math.random() * (tabelaASCII.CaracteresEspeciais2.fim - tabelaASCII.CaracteresEspeciais2.inicio + 1)) + tabelaASCII.CaracteresEspeciais2.inicio);
							break;
						case 6:
							Caracter = String.fromCharCode(Math.floor(Math.random() * (tabelaASCII.CaracteresEspeciais3.fim - tabelaASCII.CaracteresEspeciais3.inicio + 1)) + tabelaASCII.CaracteresEspeciais3.inicio);
							break;
						case 7:
							Caracter = String.fromCharCode(Math.floor(Math.random() * (tabelaASCII.CaracteresEspeciais4.fim - tabelaASCII.CaracteresEspeciais4.inicio + 1)) + tabelaASCII.CaracteresEspeciais4.inicio);
							break;
					}

					Token += Caracter;

				}

			// Retorna o Token

				return Token;

		}

//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------

	// Função que gerencia o Base64

		var Base64 = {
			_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
			encode: function(e) {
				var t="";
				var n,r,i,s,o,u,a;
				var f=0;
				e=Base64._utf8_encode(e);
				while(f<e.length){
					n=e.charCodeAt(f++);
					r=e.charCodeAt(f++);
					i=e.charCodeAt(f++);
					s=n>>2;
					o=(n&3)<<4|r>>4;
					u=(r&15)<<2|i>>6;
					a=i&63;
					if(isNaN(r)){
						u=a=64
					} else if(isNaN(i)){
						a=64
					}
					t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)
				}
				return t
			},
			decode: function(e) {
				var t="";
				var n,r,i;
				var s,o,u,a;
				var f=0;
				e=e.replace(/[^A-Za-z0-9+/=]/g,"");
				while(f<e.length){
					s=this._keyStr.indexOf(e.charAt(f++));
					o=this._keyStr.indexOf(e.charAt(f++));
					u=this._keyStr.indexOf(e.charAt(f++));
					a=this._keyStr.indexOf(e.charAt(f++));
					n=s<<2|o>>4;
					r=(o&15)<<4|u>>2;
					i=(u&3)<<6|a;
					t=t+String.fromCharCode(n);
					if(u!=64){
						t=t+String.fromCharCode(r)
					}
					if(a!=64){
						t=t+String.fromCharCode(i)
					}
				}
				t=Base64._utf8_decode(t);
				return t
			},
			_utf8_encode: function(e) {
				e=e.replace(/rn/g,"n");
				var t="";
				for(var n=0; n<e.length; n++){
					var r=e.charCodeAt(n);
					if(r<128){
						t+=String.fromCharCode(r)
					} else if(r>127&&r<2048){
						t+=String.fromCharCode(r>>6|192);
						t+=String.fromCharCode(r&63|128)
					} else {
						t+=String.fromCharCode(r>>12|224);
						t+=String.fromCharCode(r>>6&63|128);
						t+=String.fromCharCode(r&63|128)
					}
				}
				return t
			},
			_utf8_decode: function(e) {
				var t="";
				var n=0;
				var r=c1=c2=0;
				while(n<e.length){
					r=e.charCodeAt(n);
					if(r<128){
						t+=String.fromCharCode(r);
						n++
					} else if(r>191&&r<224){
						c2=e.charCodeAt(n+1);
						t+=String.fromCharCode((r&31)<<6|c2&63);
						n+=2
					} else {
						c2=e.charCodeAt(n+1);
						c3=e.charCodeAt(n+2);
						t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);
						n+=3
					}
				}
				return t
			}
		}

//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------

	// Função para Verifica o navegador é mobile/tablet ou não

		function checaAcessoMobile() {
		  var check = false;
		  var regex1 = /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i;
		  var regex2 = /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i;
		  (function(a){if(regex1.test(a)||regex2.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
		  return check;
		}

//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------