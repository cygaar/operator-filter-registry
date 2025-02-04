// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC1155} from "openzeppelin-contracts/token/ERC1155/ERC1155.sol";
import {DefaultOperatorFilterer1155, OperatorFilterer1155} from "./DefaultOperatorFilterer1155.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";

/**
 * @title  ExampleERC1155
 * @notice This example contract is configured to use the DefaultOperatorFilterer, which automatically registers the
 *         token and subscribes it to OpenSea's curated filters.
 *         Adding the onlyAllowedOperator modifier to the transferFrom and both safeTransferFrom methods ensures that
 *         the msg.sender (operator) is allowed by the OperatorFilterRegistry.
 */
abstract contract ExampleERC1155 is ERC1155(""), DefaultOperatorFilterer1155, Ownable {
    function safeTransferFrom(address from, address to, uint256 tokenId, uint256 amount, bytes memory data)
        public
        override
        onlyAllowedOperator(from, tokenId)
    {
        super.safeTransferFrom(from, to, tokenId, amount, data);
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual override onlyAllowedOperatorBatch(from, ids) {
        super.safeBatchTransferFrom(from, to, ids, amounts, data);
    }
}
