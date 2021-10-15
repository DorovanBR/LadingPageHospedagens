<form id="form_cad_contato">
  <div id="modal_cad_contato" style="display: none;">
    <div class="container-fluid">
      <div class="row">
        <div class="col-12">
          <div class="row">
            <div class="col-8 col-md-9 pt-3" id="modal_cad_contato_Nome">
              <div class="form-group" id="modal_cad_contato_div_Nome">
                <label class="control-label text-dark" for="modal_cad_contato_input_Nome">Nome Completo <span class="text-danger">*</span></label>
                <input type="text" class="form-control" name="modal_cad_contato_input_Nome">
                <div class="valid-feedback">
                  Ok!
                </div>
                <div class="invalid-feedback">
                  Verifique o campo Nome!
                </div>
              </div>
            </div>
            <div class="col-4 col-md-3 pt-3" id="modal_cad_contato_Telefone">
              <div class="form-group" id="modal_cad_contato_div_Telefone">
                <label class="control-label text-dark" for="modal_cad_contato_input_Telefone">Telefone <span class="text-danger">*</span></label>
                <input type="text" class="form-control" name="modal_cad_contato_input_Telefone">
                <div class="valid-feedback">
                  Ok!
                </div>
                <div class="invalid-feedback">
                  Verifique o campo Telefone
                </div>
              </div>
            </div>
            <div class="col-6 col-md-6 pt-3" id="modal_cad_contato_Email">
              <div class="form-group" id="modal_cad_contato_div_Email">
                <label class="control-label text-dark" for="modal_cad_contato_input_Email">E-Mail <span class="text-danger">*</span></label>
                <input type="email" class="form-control" name="modal_cad_contato_input_Email">
                <div class="valid-feedback">
                  Ok!
                </div>
                <div class="invalid-feedback">
                  Verifique o campo Email
                </div>
              </div>
            </div>
            <div class="col-6 col-md-6 pt-3" id="modal_cad_contato_Assunto">
              <div class="form-group" id="modal_cad_contato_div_Assunto">
                <label class="control-label text-dark" for="modal_cad_contato_input_Assunto">Assunto <span class="text-danger">*</span></label>
                <input type="text" class="form-control" name="modal_cad_contato_input_Assunto">
                <div class="valid-feedback">
                  Ok!
                </div>
                <div class="invalid-feedback">
                  Verifique o campo Assunto
                </div>
              </div>
            </div>
            <div class="col-12 col-md-12 pt-3" id="modal_cad_contato_Mensagem">
              <div class="form-group" id="modal_cad_contato_div_Mensagem">
                <label class="control-label text-dark" for="modal_cad_contato_input_Mensagem">Mensagem <span class="text-danger">*</span></label>
                <textarea class="form-control" name="modal_cad_contato_input_Mensagem"></textarea>
                <div class="valid-feedback">
                  Ok!
                </div>
                <div class="invalid-feedback">
                  Verifique o campo Mensagem
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-12 visible-xs visible-sm">
          <br />
        </div>
        <div class="col-12 col-md-12" style="padding-bottom: 10px;" align="center">
          <button type="button" class="btn btn-primary" id="btn-modal-enviar-contato"><i class="fa fa-plus"></i> Enviar Contato</button>
        </div>
      </div>
    </div>
  </div>
</form>