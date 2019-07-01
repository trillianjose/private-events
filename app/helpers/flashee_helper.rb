
module FlasheeHelper
  def flashee_for flash_type
    case flash_type.to_s
      when "success"
        "notification is-success"
      when "error"
        "notification is-danger"
      when "alert"
        "notification is-warning"
      when "info"
        "notification is-primary"
      else
        flash_type.to_s
    end
  end
end
