// # Copyright 2025 Yandex LLC. All rights reserved.

import UIKit

#if USE_QUESTCORE_FRAMEWORK

    import QuestCore

#endif

final class MemoryLeakViewController: UIViewController {
    var model: MemoryLeakModel!

    // MARK: - UI Elements

    private var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()

    // MARK: - Properties

    private var images: [ImageModel] = []
    private let imageManager = ImageManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupRefreshControl()
        loadImages()
    }

    // MARK: - Setup

    private func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self

        // Регистрация ячейки
        collectionView.register(MemoryLeakViewCell.self, forCellWithReuseIdentifier: MemoryLeakViewCell.identifier)

        // Или расширенный footer
        collectionView.register(
            MemoryLeakFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: MemoryLeakFooterView.identifier
        )

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(250)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(250)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16,

                                                        trailing: 16)
        // ВАЖНО: Добавляем footer
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(UIScreen.main.bounds.height) // Высота footer
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        section.boundarySupplementaryItems = [footer]
        return UICollectionViewCompositionalLayout(section: section)
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }

    @objc private func handleRefresh() {
        loadImages()
    }

    // MARK: - Data Loading

    private func loadImages() {
        images = [
            "https://staging-jubilee.flickr.com/5213/5508784414_d2d84f9c92_b.jpg",
            "https://staging-jubilee.flickr.com/4728/39256672581_c48569e3a2_b.jpg",
            "https://staging-jubilee.flickr.com/3946/14934292534_32b0302f2d_b.jpg",
            "https://staging-jubilee.flickr.com/8065/8168159947_94b3a89a2a_b.jpg",
            "https://staging-jubilee.flickr.com/7023/6581178955_7e23af8bf9_c.jpg",
            "https://staging-jubilee.flickr.com/4066/4638426067_1a979d3690_c.jpg",
            "https://staging-jubilee.flickr.com/5157/14308926248_718a76913f_c.jpg",
            "https://staging-jubilee.flickr.com/6100/6303228181_59371c29dc_c.jpg",
            "https://staging-jubilee.flickr.com/8018/7380380362_0589be0be1_c.jpg",
            "https://live.staticflickr.com/3107/2321136879_60075fbc4e_c.jpg",
            "https://live.staticflickr.com/4040/4287957442_fe8062f0df_c.jpg",
            "https://live.staticflickr.com/3436/3717404325_db41d8d687_c.jpg",
            "https://live.staticflickr.com/4035/4628642473_ba24c6309a_c.jpg",
            "https://live.staticflickr.com/3953/15555878422_0c80e2dbff_c.jpg",
            "https://live.staticflickr.com/4418/36982040056_fa9a432ff9_c.jpg",
            "https://live.staticflickr.com/6216/6240217938_aeed84634a_c.jpg",
            "https://live.staticflickr.com/4126/5047618897_2c581d847d_c.jpg",
            "https://live.staticflickr.com/5081/5269581962_0015d5409f_c.jpg",
            "https://live.staticflickr.com/754/22964770794_707fbdc5d5_c.jpg",
            "https://live.staticflickr.com/5498/12440527344_c8a980cf57_c.jpg",
            "https://live.staticflickr.com/7182/6895468439_81a2b7af46_c.jpg",
            "https://live.staticflickr.com/3241/3084573917_dcbed5875d_c.jpg",
            "https://live.staticflickr.com/979/41425309775_08bece5cca_c.jpg",
            "https://live.staticflickr.com/8481/29068166132_9c79317705_c.jpg",
            "https://live.staticflickr.com/2746/4300367010_96cffff86f_c.jpg",
            "https://live.staticflickr.com/4013/4276542790_1cb7804331_c.jpg",
            "https://live.staticflickr.com/4196/34042269044_31a90deee4_c.jpg",
            "https://live.staticflickr.com/2277/1640123767_1fd2cdc805_z.jpg",
            "https://live.staticflickr.com/8609/16169099399_bd393db803_z.jpg",
            "https://live.staticflickr.com/6022/6208329904_0bed3bab3d_z.jpg",
            "https://live.staticflickr.com/7209/7063856691_2a35a039cd_z.jpg",
            "https://live.staticflickr.com/1204/1090235720_da0ca9dc95_z.jpg",
            "https://live.staticflickr.com/4248/34549084163_a211fa4226_z.jpg",
            "https://live.staticflickr.com/3380/5694555025_f5e8c455af_z.jpg",
            "https://live.staticflickr.com/8614/16565515549_e3c3b755aa_z.jpg",
            "https://live.staticflickr.com/3622/3375160588_dfd9f17597.jpg",
            "https://live.staticflickr.com/2883/13674201545_4bc9160dcc.jpg",
            "https://live.staticflickr.com/3955/15613863252_27306fcb58.jpg",
            "https://live.staticflickr.com/3846/14710986449_7efca567c1.jpg",
            "https://live.staticflickr.com/2077/2243197414_0a78dccfc2.jpg",
            "https://live.staticflickr.com/7580/16084926560_f59ed550b8.jpg",
            "https://live.staticflickr.com/1420/1045901686_1f06406efa.jpg",
            "https://live.staticflickr.com/7274/7699866028_8653598e47.jpg",
        ].enumerated().map { index, element in
            ImageModel(
                id: "\(index)",
                title: "Изображение \(index)",
                url: element
            )
        }

        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MemoryLeakViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoryLeakViewCell.identifier, for: indexPath) as! MemoryLeakViewCell

        let imageModel = images[indexPath.item]
        cell.configure(with: imageModel, imageManager: imageManager)

        return cell
    }

    // ВАЖНО: Этот метод создает footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            // Выберите нужный footer
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MemoryLeakFooterView.identifier,
                for: indexPath
            ) as! MemoryLeakFooterView

            footer.delegate = self
            footer.configure(
                title: "Просмотрели все изображения?",
                subtitle: "Переходите к следующему разделу",
                buttonTitle: "Далее →",
                isEnabled: true
            )

            return footer
        }

        return UICollectionReusableView()
    }
}

// MARK: - UICollectionViewDelegate

extension MemoryLeakViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageModel = images[indexPath.item]
        print(imageModel.title)
    }
}

// MARK: - Footer Delegates

extension MemoryLeakViewController:

    MemoryLeakFooterViewDelegate
{
    func footerDidTapGoNext(_ footer: MemoryLeakFooterView) {
        print("Go Next button tapped!")

        // Показываем загрузку
        footer.setLoading(true)

        // Симуляция асинхронной операции
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            footer.setLoading(false)

            // Показываем успех или переходим к следующему экрану
            if self.imageManager.hasTasks() == false {
                footer.showSuccess()
                self.navigateToNextScreen()
            } else {
                footer.showError("Не все ImageDataTask завершены")
            }
        }
    }

    private func navigateToNextScreen() {
        model.goToNextStep()
    }
}

// MARK: - Image Model

struct ImageModel {
    let id: String
    let title: String
    let url: String
}
