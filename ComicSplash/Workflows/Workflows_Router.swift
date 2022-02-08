//
//  Workflows.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation
import os
import R2DFlow

enum ComicSelector: LabelAccessible {
    case previous
    case newer
    case latest
    case number(Int)
}

class Workflows: Workflow<MainState> {

    let log = Logger(category: "Workflows")

    let comicModel = ComicModel()
    let favoritesModel = FavoritesModel()

    // MARK: - Action receiver and workflow router.

    override func run(_ action: WorkflowAction) {

        log.info("\(action.label)")

        switch action {

        case .getLatestComics:
            getLatestComics()

        case .getPreviousComic:
            getPreviousComic()

        case .getNewerComic:
            getNewerComic()

        case .getRandomComics:
            getRandomComics()

        case .getComicsNear(let num):
            getComicsNear(num)

        case .addComicAsFavorite(let num):
            addComicAsFavorite(num)

        case .removeComicFromFavorites(let num):
            removeComicFromFavorite(num)

        case .getFavoriteComics:
            getFavoriteComics()

        case .startSpeaking(let transcript):
            startSpeaking(transcript)

        }
    }
}
