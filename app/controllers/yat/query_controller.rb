class Yat::QueryController < Yat::SecurityController
  layout 'yat'

  def index
  end

  def group(id=params[:node])
    respond_to do |format|
      format.html # render static index.html.erb
      format.json { render :json => Group.find_children(id) }
    end
  end

end