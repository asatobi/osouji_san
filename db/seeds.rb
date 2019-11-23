cleaning_places = [
  'トイレ(女性)',
  'トイレ(男性①)',
  'トイレ(男性②)',
  'キッチン',
  'レンジ・冷蔵庫周り',
  'テーブル・本棚',
  'コーヒー・ウォーターサーバ',
  'ダンボール',
  '備品チェック',
  '掃除機',
  '会議室',
  'エントランス',
  '水やり'
]

# enum gender: { male: 0, female: 1 }
users = {
  'chiekimura': 1,
  'han.sansoo': 0,
  'hatashima': 0,
  'itabashi-aguru': 0,
  'jung_jiyeon': 1,
  'kawamoto': 0,
  'maeno': 0,
  'midorikawa': 0,
  'nang': 1,
  'tobi.asato': 1,
  'watanabe_bruno': 0,
  'yamasakiasanobu': 0,
  'ykwark': 0
}

ActiveRecord::Base.transaction do
  # cleaning_places.each do |cleaning_place|
  #   CleaningPlace.create!(name: cleaning_place)
  # end

  users.each do |name, gender|
    User.create!(
      name: "@#{name}",
      gender: gender
    )
  end
end
