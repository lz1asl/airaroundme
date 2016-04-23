class SympthomController < ApplicationController

  def list
    @sympthoms =  Sympthom .all
    render json: @sympthoms, :only => [:id, :label]
  end
end
