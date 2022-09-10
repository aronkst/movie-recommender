module StatesHelper
  def button_state(state, value, button, from_search, &block)
    button_to states_upsert_path(state.imdb), method: :post, form_class: 'inline',
                                              class: "btn #{state.value == value ? '' : 'btn-outline'} #{button} mr-2 mt-2", params: { value:, from_search: }, &block
  end
end
