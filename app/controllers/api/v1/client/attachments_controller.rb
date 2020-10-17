# frozen_string_literal: true

module Api
  module V1
    module Client
      class AttachmentsController < Api::V1::ApiController
        def_param_group(:attachment) do
          property :id, Integer
          property :url, String
          property :added_by, String
          param :filename, String, required: true
          param :content_type, String, required: true
          param :data, String,
                desc: 'Base64 representation: e.g. data:image/png;base64,iVBORw0KGgoAAAANS..',
                required: true, only_in: :request
        end

        api :GET, 'clients/:id/attachments.json', 'Get Client Attachments'
        param :query, String
        returns array_of: :attachment, desc: 'This Api will return array of Attachments'

        def index
          render json: client.attachments
        end

        api :POST, 'clients/:id/attachments.json', 'Create attachment'
        param_group :attachment
        returns :attachment, code: 201, desc: 'a successful response'

        def create
          att = client.attachments.new(user: current_user)
          if att.save && att.file.attach(data: params[:data],
                                         filename: params[:filename],
                                         content_type: params[:content_type])
            render json: att, each_serializer: AttachmentSerializer
          else
            att.destroy
            render_error(422, 'Unable to upload attachment.')
          end
        end

        api :DELETE, 'clients/:id/attachments/delete.json', 'Delete attachments'
        param :ids, Array, desc: 'Ids of attachments to delete'
        returns code: 200, desc: 'a successful response' do
          property :message, String, desc: 'attachments deleted successfully.'
        end

        def delete
          attachments = client.attachments.where id: params[:ids]
          attachments.destroy_all
          render_message('attachments deleted successfully.')
        end

        private

        def client
          @client ||= current_user.clients.find params[:client_id]
        end
      end
    end
  end
end
