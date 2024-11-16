require 'swagger_helper'

RSpec.describe 'api/v1/notes', type: :request do
  path '/api/v1/notes' do
    get('Список заметок') do
      response(200, 'Успешный запрос') do
        produces 'application/json'
        schema type: :object, properties: {
          data: {
            type: :array,
            items: { '$ref' => '#/components/schemas/note/show' }
          }
        }

        run_test!
      end
    end

    post('Создать заметку') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :note, in: :body, schema: {
        '$ref' => '#/components/schemas/note/new'
      }

      response(200, 'Успешный запрос') do
        schema '$ref' => '#/components/schemas/note/new'

        let(:note) { { title: 'foo', description: 'bar' } }
        run_test!
      end

      response(422, 'Неправильный запрос') do
        schema '$ref' => '#/components/schemas/base/unprocessable_entity'

        let(:note) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/notes/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('Показать заметку') do
      produces 'application/json'

      response(200, 'Заметка найдена') do
        schema '$ref' => '#/components/schemas/note/show'

        let(:id) { Note.create(title: 'foo', description: 'bar').id }
        run_test!
      end

      response(404, 'Заметка не найдена') do
        schema '$ref' => '#/components/schemas/base/not_found'

        let(:id) { 10 }

        run_test!
      end
    end

    patch('Обновить заметку') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :note, in: :body, schema: {
        '$ref' => '#/components/schemas/note/new'
      }

      response(200, 'Успешный запрос') do
        schema '$ref' => '#/components/schemas/base/success'

        let(:note) { Note.create(title: 'foo', description: 'bar') }
        let(:id) { note.id }

        run_test!
      end
    end

    delete('Удалить заметку') do
      produces 'application/json'

      response(200, 'Успешный запрос') do
        schema '$ref' => '#/components/schemas/base/success'

        let(:id) { Note.create(title: 'foo', description: 'bar').id }

        run_test!
      end
    end
  end
end
