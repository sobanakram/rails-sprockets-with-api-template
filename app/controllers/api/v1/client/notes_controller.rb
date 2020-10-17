# frozen_string_literal: true

module Api
  module V1
    module Client
      class NotesController < Api::V1::ApiController
        def_param_group(:note) do
          property :id, Integer
          property :created_at, Time
          param :content, String, required: true
        end

        api :GET, 'clients/:id/notes.json', 'Get Client Notes'
        param :query, String
        returns array_of: :note, desc: 'This Api will return array of Notes'

        def index
          render json: client.notes.with_user
        end

        api :POST, 'clients/:id/notes.json', 'Create Note'
        param_group :note
        returns :note, code: 201, desc: 'a successful response'

        def create
          note = client.notes.new(note_params)
          note.save ? render_resource(note) : render_resource_error(note)
        end

        api :PUT, 'clients/:id/notes/:id.json', 'Update Note'
        param_group :note
        returns :note, code: 200, desc: 'a successful response'

        def update
          note = client.notes.find params[:id]
          note.update(note_params) ? render_resource(note, 200) : render_resource_error(note)
        end

        api :DELETE, 'clients/:id/notes/delete.json', 'Delete Notes'
        param :ids, Array, desc: 'Ids of notes to delete'
        returns code: 200, desc: 'a successful response' do
          property :message, String, desc: 'Notes deleted successfully.'
        end

        def delete
          notes = client.notes.where id: params[:ids]
          notes.destroy_all
          render_message('Notes deleted successfully.')
        end

        private

        def note_params
          params.permit(:content).merge(user_id: current_user.id)
        end

        def client
          @client ||= current_user.clients.find params[:client_id]
        end
      end
    end
  end
end
