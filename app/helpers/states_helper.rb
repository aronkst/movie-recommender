module StatesHelper
  def button_state(state, value, button, from_search)
    button_class = "btn #{state.value == value ? '' : 'btn-outline'} #{button} mr-2 mt-2"
    button_to states_upsert_path(state.imdb), method: :post, form_class: 'inline', class: button_class,
                                              params: { value: value, from_search: from_search } do
      yield
    end
  end
end
