require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }

  permissions :index? do
    context 'admin' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'admin'), Fabricate.times(3, :user))
      end
    end

    context 'user' do
      it 'denies access' do
        expect(subject).not_to permit(Fabricate(:user, role: 'user'), Fabricate.times(3, :user))
      end
    end

    context 'guest' do
      it 'denies access' do
        expect(subject).not_to permit(Fabricate(:user, role: 'guest'), Fabricate.times(3, :user))
      end
    end
  end

  permissions :show? do
    context 'admin' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'admin'), Fabricate(:user))
      end
    end

    context 'user' do
      let(:user) { Fabricate(:user, role: 'user') }

      it 'grants access' do
        expect(subject).to permit(user, user)
      end
    end

    context 'guest' do
      let(:user) { Fabricate(:user, role: 'guest') }

      it 'grants access' do
        expect(subject).to permit(user, user)
      end
    end
  end

  permissions :update? do
    context 'admin' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'admin'), Fabricate(:user))
      end
    end

    context 'user' do
      let(:user) { Fabricate(:user, role: 'user') }

      it 'grants access' do
        expect(subject).to permit(user, user)
      end
    end

    context 'guest' do
      let(:user) { Fabricate(:user, role: 'guest') }

      it 'grants access' do
        expect(subject).to permit(user, user)
      end
    end
  end

  permissions :destroy? do
    context 'admin' do
      it 'grants access' do
        expect(subject).to permit(Fabricate(:user, role: 'admin'), Fabricate(:user))
      end
    end

    context 'user' do
      let(:user) { Fabricate(:user, role: 'user') }

      it 'grants access' do
        expect(subject).to permit(user, user)
      end
    end

    context 'guest' do
      let(:user) { Fabricate(:user, role: 'guest') }

      it 'grants access' do
        expect(subject).to permit(user, user)
      end
    end
  end
end
