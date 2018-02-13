module EncorDividend
  extend ActiveSupport::Concern

  def start
    system "rake encor_solar:dividend"
    redirect_to :pages_home
  end
end