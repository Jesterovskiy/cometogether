##
# Module: Helpers for tests
#
module Helpers
  def event_hash(event)
    {
      'type' => 'events',
      'id'   => event.id,
      'attributes' =>
      {
        'id'          => event.id,
        'name'        => event.name,
        'description' => event.description,
        'location'    => event.location,
        'date'        => event.date.iso8601(3),
        'user_id'     => event.user_id,
        'created_at'  => event.created_at.iso8601(3),
        'updated_at'  => event.updated_at.iso8601(3)
      }
    }
  end

  def item_hash(item)
    {
      'type' => 'items',
      'id'   => item.id,
      'attributes' =>
      {
        'id'          => item.id,
        'description' => item.description,
        'comment'     => item.comment,
        'event_id'    => item.event_id,
        'created_at'  => item.created_at.iso8601(3),
        'updated_at'  => item.updated_at.iso8601(3)
      }
    }
  end

  def user_hash(user)
    {
      'type' => 'users',
      'id'   => user.id,
      'attributes' =>
      {
        'id'              => user.id,
        'first_name'      => user.first_name,
        'last_name'       => user.last_name,
        'email'           => user.email,
        'password_digest' => user.password_digest,
        'role'            => user.role,
        'auth_token'      => user.auth_token,
        'created_at'      => user.created_at.iso8601(3),
        'updated_at'      => user.updated_at.iso8601(3)
      }
    }
  end
end
