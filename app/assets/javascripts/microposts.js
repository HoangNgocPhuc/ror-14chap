$(document).ready(function(){
  $('#micropost_picture').change(function(){
    var maximum_picture = $('#new_micropost').data('maximum');
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > maximum_picture) {
      alert(I18n.t("microposts.model.picture_warning"));
    }
  });
})
