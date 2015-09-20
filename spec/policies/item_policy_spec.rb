require 'rails_helper'

RSpec.describe ItemPolicy do
  subject { described_class }

  permissions :index? do
    context 'admin' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'admin'), Fabricate.times(3, :item))
      end
    end

    context 'user' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'user'), Fabricate.times(3, :item))
      end
    end

    context 'guest' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'guest'), Fabricate.times(3, :item))
      end
    end
  end

  permissions :show? do
    context 'admin' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'admin'), Fabricate(:item))
      end
    end

    context 'user' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'user'), Fabricate(:event))
      end
    end

    context 'guest' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'guest'), Fabricate(:event))
      end
    end
  end

  permissions :create? do
    context 'admin' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'admin'), Fabricate(:item))
      end
    end

    context 'user' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'user'), Fabricate(:item))
      end
    end

    context 'guest' do
      it 'denies access' do
        expect(subject).not_to permit(Fabricate(:user, role: 'guest'), Fabricate(:item))
      end
    end
  end

  permissions :update? do
    context 'admin' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'admin'), Fabricate(:item))
      end
    end

    context 'user' do
      let(:user)  { Fabricate(:user, role: 'user') }
      let(:event) { Fabricate(:event, user: user) }

      it 'grants access if event belongs to user' do
        expect(subject).to permit(user, Fabricate(:item, event: event))
      end
    end

    context 'guest' do
      it 'denies access' do
        expect(subject).not_to permit(Fabricate(:user, role: 'guest'), Fabricate(:item))
      end
    end
  end

  permissions :destroy? do
    context 'admin' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'admin'), Fabricate(:item))
      end
    end

    context 'user' do
      let(:user)  { Fabricate(:user, role: 'user') }
      let(:event) { Fabricate(:event, user: user) }

      it 'grants access if event belongs to user' do
        expect(subject).to permit(user, Fabricate(:item, event: event))
      end
    end

    context 'guest' do
      it 'denies access' do
        expect(subject).not_to permit(Fabricate(:user, role: 'guest'), Fabricate(:item))
      end
    end
  end
end
