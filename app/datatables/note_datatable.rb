class NoteDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :note_path
  def_delegator :@view, :edit_note_path
  def_delegator :@view, :content_tag
  def_delegator :@view, :concat

  def initialize(params, opts = {})
    @view = opts[:view_context]
    @current_user = opts[:current_user]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Note.id" },
      created_at: { source: "Note.created_at" },
      title: { source: "Note.title"},
      body: { source: "Note.body"}
    }
  end

  def data
    records.map do |record|
      {
        id: link_to("##{record.id}", note_path(record)),
        created_at: record.created_at.strftime("%d-%m-%Y %I:%M %p"),
        title: record.title,
        body: record.body,
        short_body: record.body[0..50],
        actions: content_tag(:div, class: "d-flex justify-content-start align-items-center") do
          concat(link_to '<i class="far fa-edit text-dark"></i>'.html_safe, edit_note_path(record), :data => { remote: true, method: 'get', 'target' => '#editModal', 'pt-title' => "Edit" }, class: "mr-3 protip")
          concat(link_to '<i class="far fa-trash-alt text-danger"></i>'.html_safe, note_path(record), method: :delete, :data => { remote: true, :toggle => "tooltip", :placement=>"top", :confirm => "Are you sure you want to delete this note?", 'pt-title' => "Delete" }, class: "mr-3 protip")
        end,
        DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    @current_user.notes
  end
end
