class StaticController < ApplicationController
  def about
    @title ="#{APP_SUB_TITLE}について"
  end

  def data
    @title = "データについて"
  end
end
